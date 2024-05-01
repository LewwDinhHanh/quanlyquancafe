using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApp1.DTO
{
    public class Food
    {

        public Food(int id,string name, int CategoryID, float price)
        {
            this.ID = id;
            this.Name = name;
            
            this.CategoryID1= CategoryID;
            this.Price = price;
        }

        public Food(DataRow row)
        {
            this.ID = (int)row["ID"];
            this.Name= (string)row["Name"];
            
            this.CategoryID1= (int)row["idcategory"];
            this.Price = (float)Convert.ToDouble(row["price"].ToString());
        }
        private int iD;
        private string name;
        private int CategoryID;
        private float price;

        public int ID { get => iD; set => iD = value; }
        public string Name { get => name; set => name = value; }
        public int CategoryID1 { get => CategoryID; set => CategoryID = value; }
        public float Price { get => price; set => price = value; }
    }
}
