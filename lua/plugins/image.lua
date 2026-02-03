return {
  {
    "3rd/image.nvim",
    -- Load on specific file types and commands, not VeryLazy
    -- This ensures it loads properly in tmux
    ft = { "markdown", "vimwiki", "norg" },
    event = {
      "BufReadPre *.png",
      "BufReadPre *.jpg",
      "BufReadPre *.jpeg",
      "BufReadPre *.gif",
      "BufReadPre *.webp",
      "BufReadPre *.bmp",
      "BufReadPre *.avif",
    },
    cmd = { "ImageToggle", "ImageClear" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate html",
      },
    },
    opts = {
      backend = "kitty",
      -- Required for tmux support - allows kitty graphics protocol passthrough
      kitty_method = "normal",

      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" },
        },
        neorg = {
          enabled = true,
          filetypes = { "norg" },
        },
        html = {
          enabled = false,
        },
        css = {
          enabled = false,
        },
      },

      -- Size constraints to prevent freezing on large images
      max_width = 100, -- Max width in terminal columns
      max_height = 30, -- Max height in terminal rows
      max_width_window_percentage = 80, -- Max width as percentage of window
      max_height_window_percentage = 50, -- Max height as percentage of window

      -- Window overlap settings
      window_overlap_clear_enabled = true, -- Clear images when window overlaps
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "" },

      -- Editor-only images (not in neovim's process memory for better performance)
      editor_only_render_when_focused = true, -- Only render when neovim is focused

      -- Tmux-specific settings - auto-detected
      tmux_show_only_in_active_window = true, -- Only show images in active tmux window

      -- IMPORTANT: Disable built-in hijack - we'll handle it ourselves with error handling
      hijack_file_patterns = {},
    },
    config = function(_, opts)
      require("image").setup(opts)

      -- Custom hijack with graceful error handling
      local image_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.bmp", "*.avif" }

      local function safe_hijack_buffer(path, win, buf)
        local ok, err = pcall(function()
          require("image").hijack_buffer(path, win, buf)
        end)

        if not ok then
          -- Restore buffer to normal state
          vim.schedule(function()
            pcall(function()
              vim.bo[buf].modifiable = true
              vim.bo[buf].buftype = ""
              vim.bo[buf].filetype = ""
            end)

            -- Extract meaningful error message
            local error_msg = "Unknown error"
            if type(err) == "string" then
              -- Try to get a cleaner error message
              local match = err:match("magick: (.-)%s*@") or err:match("Error[^:]*:%s*(.-)$") or err
              error_msg = match:sub(1, 100) -- Limit length
            end

            -- Show friendly notification
            vim.notify(
              string.format("Cannot render image: %s\n\nFile: %s", error_msg, vim.fn.fnamemodify(path, ":t")),
              vim.log.levels.WARN,
              { title = "image.nvim" }
            )

            -- Set buffer content to show error info
            pcall(function()
              vim.bo[buf].modifiable = true
              local filename = vim.fn.fnamemodify(path, ":t")
              local filesize = vim.fn.getfsize(path)
              local filesize_str = filesize > 1024 * 1024
                  and string.format("%.2f MB", filesize / 1024 / 1024)
                or filesize > 1024 and string.format("%.2f KB", filesize / 1024)
                or string.format("%d bytes", filesize)

              vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
                "",
                "  Unable to render image",
                "",
                "  File: " .. filename,
                "  Size: " .. filesize_str,
                "  Path: " .. path,
                "",
                "  Error: " .. error_msg,
                "",
                "  Possible causes:",
                "    - Unsupported image format",
                "    - Corrupted image file",
                "    - Missing ImageMagick codecs",
                "",
                "  Press 'q' to close this buffer",
              })
              vim.bo[buf].modifiable = false
              vim.bo[buf].buftype = "nofile"

              -- Add 'q' to close buffer
              vim.keymap.set("n", "q", "<cmd>bdelete<cr>", { buffer = buf, silent = true })
            end)
          end)
        end
      end

      -- Create autocmd group for our custom hijack
      local group = vim.api.nvim_create_augroup("ImageNvimSafeHijack", { clear = true })

      vim.api.nvim_create_autocmd({ "BufWinEnter", "WinNew", "TabEnter" }, {
        group = group,
        pattern = image_patterns,
        callback = function(event)
          local buf = event.buf
          local win = vim.api.nvim_get_current_win()
          local path = vim.api.nvim_buf_get_name(buf)

          -- Skip if already processed or invalid
          if vim.bo[buf].filetype == "image_nvim" then
            return
          end

          safe_hijack_buffer(path, win, buf)
        end,
      })
    end,
    keys = {
      {
        "<leader>ti",
        function()
          require("image").toggle_images()
        end,
        desc = "Toggle images",
      },
      {
        "<leader>ci",
        function()
          require("image").clear_images()
        end,
        desc = "Clear images",
      },
    },
  },
}
