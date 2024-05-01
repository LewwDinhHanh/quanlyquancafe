using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApp1.DTO
{
    public class Menu
    {
        public Menu(string foodName, int count, float Price, float totalPrice = 0)
        {
            this.FoodName = foodName;
            this.Count = count;
            this.Price1 = Price;
            this.TotalPrice = totalPrice;
        }

        public Menu(DataRow row)
        {
            this.FoodName = row["Name"].ToString();
            this.Count = (int)row["count"];
            this.Price1 = (float)Convert.ToDouble(row["price"].ToString());
            this.TotalPrice = (float)Convert.ToDouble(row["totalPrice"].ToString());
        }

        private string foodName;
        private int count;
        private float Price;
        private float totalPrice;

        public string FoodName { get => foodName; set => foodName = value; }
        public int Count { get => count; set => count = value; }
        public float Price1 { get => Price; set => Price = value; }
        public float TotalPrice { get => totalPrice; set => totalPrice = value; }
    }
}
