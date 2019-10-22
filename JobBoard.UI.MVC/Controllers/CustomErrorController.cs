using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace JobBoard.UI.MVC.Controllers
{
    public class CustomErrorController : Controller
    {
        // GET: CustomError
        public ActionResult OpenPositionsError()
        {
            return View();
        }
    }
}