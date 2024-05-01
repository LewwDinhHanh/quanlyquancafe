using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApp1.DTO
{
    public class Bill
    {

        public Bill(int id, DateTime? dateCheckin, DateTime? dataCheckOut,int status,int discount = 0) { 
             this.ID= id;
            this.DateCheckIn= dateCheckin;
            this.DateCheckOut = dataCheckOut;
            this.Status = status;
            this.Discount = discount;
        }

        public Bill(DataRow row) {
            this.ID = (int)row["ID"];
            this.DateCheckIn = (DateTime?)row["dateCheckIn"];
            var dateCheckOutTemp = row["dateCheckOut"];
            if (dateCheckOutTemp.ToString() != "")
            {
                this.DateCheckOut = (DateTime?)dateCheckOutTemp; ;
            }
            this.Status = (int)row["status"];
            this.Discount = (int)row["discount"];
        }

        private int discount;
        private int ID;
        private DateTime? dateCheckIn;
        private DateTime? dateCheckOut;
        private int status;

        public int ID1 { get => ID; set => ID = value; }
        public DateTime? DateCheckIn { get => dateCheckIn; set => dateCheckIn = value; }
        public DateTime? DateCheckOut { get => dateCheckOut; set => dateCheckOut = value; }
        public int Status { get => status; set => status = value; }
        public int Discount { get => discount; set => discount = value; }
    }
}
