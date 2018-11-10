using byte4bite_hackathon.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace byte4bite_hackathon.Controllers
{
    public class InventoryController : Controller
    {
        // GET: Inventory
        public ActionResult Index()
        {
            return View();
        }

        //get all of the products for a pantry
        public JsonResult GetProductsForPantry(int pantryID)
        {
            using (var context = new HackathonEntities())
            {
                var inventory = context.FoodPantryStocks.Where(fps => fps.FoodPantryID == pantryID)
                    .Select(fps => new
                    {
                        fps.ItemID,
                        ItemName = fps.Item.Name,
                        ItemCount = fps.Quantity,
                        RequestCount = fps.Item.RequestedItems.Count(ri => ri.FoodPantryID == pantryID
                            && ri.Quantity > 0
                            && ri.FulfillByDate > DateTime.Now),
                        Points = fps.Item.PointValue,
                    }).ToList();
                return Json(inventory);
            }
        }
    }
}