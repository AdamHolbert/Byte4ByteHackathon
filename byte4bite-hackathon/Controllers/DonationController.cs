using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace byte4bite_hackathon.Controllers
{
    public class DonationController : Controller
    {
        // GET: Donation
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult AddDonation(int amount)
        {
            // add amount to db table
            // calculate amount to number of students
            return Json(new { amount, studentNum = 5 });
        }
    }
}