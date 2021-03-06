﻿using byte4bite_hackathon.Database;
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
                var mindate = DateTime.Now.AddDays(-7);
                var families = context.Families.Select(f =>
                new {
                    f.ID,
                    f.FamilyID,
                    f.FamilySize,
                    LastOrderDate = !f.Orders.Any() ? "Never" : f.Orders.OrderByDescending(o => o.OrderDate).FirstOrDefault().OrderDate.ToString(),
                    LastVisitedPoints = !f.Orders.Any() ? "0" : f.Orders.OrderByDescending(o => o.OrderDate).FirstOrDefault().PointTotal.ToString(),
                    MaxOrderQuantity = f.MaxPointTotal,
                    //UsedOrderQuantity = f.Orders.Where(o => o.OrderDate < mindate).Sum(o => o.PointTotal)
                }).ToList();

                return Json(families);
            }
        }
    }
}