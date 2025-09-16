using System;
using System.Collections.Generic;

namespace TestProject
{
    public class TestFormat
    {
        public void BadlyFormattedMethod()
        {
            var list = new List<string>() { "item1", "item2" };
            foreach (var item in list)
            {
                Console.WriteLine(item);
            }
        }
    }
}
