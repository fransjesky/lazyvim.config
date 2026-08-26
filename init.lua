-- Go: skip IPv6 checksum DB (no IPv6 internet on this machine)
vim.env.GONOSUMDB = "*"

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Load React/JSX filetype detection
require("filetype.react")

-- Load PHP/Laravel filetype detection
require("filetype.php")
