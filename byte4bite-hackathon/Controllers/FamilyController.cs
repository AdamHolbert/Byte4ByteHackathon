using byte4bite_hackathon.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace byte4bite_hackathon.Controllers
{
    public class FamilyController : Controller
    {
        // GET: Family
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult GetFamilies()
        {
            using (var context = new HackathonEntities())
            {
                var families = context.Families.Select(f =>
                new {
                    f.ID,
                    f.FamilyID,
                    f.FamilySize,
                    MaxOrderQuantity = f.MaxPointTotal,
                    UsedOrderQuantity = f.Orders.Where(o => o.OrderDate < DateTime.Now.AddDays(-7)).Sum(o => o.PointTotal)
                });
                return Json(families);
            }
        }

        public JsonResult 
    }
}