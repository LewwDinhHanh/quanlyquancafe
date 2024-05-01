using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApp1.DTO
{
    public class BillInfo
    {

        public BillInfo(int id, int billID, int foodID,int count) {
            this.ID= id;
            this.BillID= billID;    
            this.FoodID= foodID;
            this.Count= count;
        }   

        public BillInfo(DataRow row) {
            this.ID = (int)row["ID"];
            this.billID = (int)row["idbill"];
            this.foodID = (int)row["idfood"];
            this.count = (int)row["count"];
        }

        private int ID;
        private int billID;
        private int count;
        private int foodID;

        public int ID1 { get => ID; set => ID = value; }
        public int BillID { get => billID; set => billID = value; }
        public int Count { get => count; set => count = value; }
        public int FoodID { get => foodID; set => foodID = value; }
    }
}
