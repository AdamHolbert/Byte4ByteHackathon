using byte4bite_hackathon.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace byte4bite_hackathon.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult GetData(int id)
        {
            return Json($"This is some data from the server, you passed {id}");
        }

        public JsonResult GetDummyTemplateInfo()
        {
            using (var context = new HackathonEntities())
            {
                var items = context.Items.Where(i => i.ID < 100).Select(i => new
                {
                    i.ID,
                    i.Name
                }).ToList();
                var obj = new
                {
                    Fullname = "Adam",
                    Age = 29,
                    Items = items
                };
                return Json(obj);
            }
        }

        public JsonResult GetDropDownData()
        {
            Dictionary<int, string> dropdownitems = new Dictionary<int, string>();
            dropdownitems.Add(1, "First");
            dropdownitems.Add(2, "Second");
            dropdownitems.Add(3, "Third");
            dropdownitems.Add(4, "Fourth");
            return Json(dropdownitems.ToList());
        }

        //list of families
        //family number
        //last order date
        //max order quantity
        //remaining order quantity


        //pantry items
        //family information
        public JsonResult CreatNewItem()
        {
            //edmx access example
            using (var context = new HackathonEntities())
            {
                //retreive an object from the database
                var something = context.Orders.FirstOrDefault(o => o.ID == 1);

                //creates a new item
                var item = new Item()
                {
                    Name = "Green Beans",
                    Price = 1.00m
                };
                //adds the item to the database
                context.Items.Add(item);
                //executes the save of anything manipulated
                context.SaveChanges();
            }
            //json return to take actions on in the js
            return Json(false);
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }


        public ActionResult LoggedIn()
        {
            ViewBag.Message = "Your contact page.";
            return View();
        }

        public ActionResult Family()
        {

            return View();
        }
    }
}