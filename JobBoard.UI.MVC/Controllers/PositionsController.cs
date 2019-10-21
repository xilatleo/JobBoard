using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using JobBoard.DATA.EF;
using Microsoft.AspNet.Identity;
using PagedList; 
using PagedList.Mvc;

namespace JobBoard.UI.MVC.Controllers
{
    public class PositionsController : Controller
    {
        private JobBoardSiteEntities db = new JobBoardSiteEntities();

        // GET: Positions
        [Authorize(Roles = "Admin, Manager")]
        public ActionResult Index(string searchString, string currentFilter, int page = 1)
        {
            int pageSize = 5;
            var position = db.Positions.ToList();
            if (searchString != null)
            {
                page = 1;
            }
            else
            {
                searchString = currentFilter;
            }
            ViewBag.CurrentFilter = searchString;

            if (!String.IsNullOrEmpty(searchString))
            {
                position = (from p in position
                            where p.Title.ToLower().Contains(searchString.ToLower())
                           
                            select p).ToList();
            }
            ViewBag.CurrentFilter = searchString;
            return View(position.ToPagedList(page, pageSize));

        }

        // GET: Positions/Details/5
        [Authorize(Roles = "Admin, Manager")]
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Position position = db.Positions.Find(id);
            if (position == null)
            {
                return HttpNotFound();
            }
            return View(position);
        }

        // GET: Positions/Create
        [Authorize(Roles = "Admin, Manager")]
        public ActionResult Create()
        {
            return View();
        }

        // POST: Positions/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "PositionID,Title,JobDescription")] Position position)
        {
            if (ModelState.IsValid)
            {
                db.Positions.Add(position);
                db.SaveChanges();
                return RedirectToAction("Index", "OpenPositions");
            }

            return View(position);
        }

        // GET: Positions/Edit/5
        [Authorize(Roles = "Admin, Manager")]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Position position = db.Positions.Find(id);
            if (position == null)
            {
                return HttpNotFound();
            }
            return View(position);
        }

        // POST: Positions/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "PositionID,Title,JobDescription")] Position position)
        {
            if (ModelState.IsValid)
            {
                db.Entry(position).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(position);
        }

        // GET: Positions/Delete/5
        [Authorize(Roles = "Admin, Manager")]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Position position = db.Positions.Find(id);
            if (position == null)
            {
                return HttpNotFound();
            }
            return View(position);
        }

        // POST: Positions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Position position = db.Positions.Find(id);
            db.Positions.Remove(position);
            db.SaveChanges();
            return RedirectToAction("Index");
        }


        // GET: Positions/Apply/1
        [Authorize]
        public ActionResult Apply(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Position position = db.Positions.Find(id);
            if (position == null)
            {
                return HttpNotFound();
            }
            return View(position);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Apply(int id)
        {
            Application ctx = new Application();
            Position position = db.Positions.Find(id);
            OpenPosition open = db.OpenPositions.Where(op => op.PositionID==id).FirstOrDefault();
            //open.PositionID = open.OpenPositionID;

            string userID = User.Identity.GetUserId();
            UserDetail currentUser = db.UserDetails.Where(ud => ud.UserID == userID).FirstOrDefault();

            
            ctx.OpenPositionID = open.OpenPositionID;           
            ctx.UserID = currentUser.UserID;
            ctx.ApplicationDate = DateTime.Today.Date;
            ctx.ResumeFileName = currentUser.ResumeFileName;
            ctx.ApplicationStatusID = 1;
            db.Applications.Add(ctx);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        [AcceptVerbs(HttpVerbs.Post)]         
       
        public JsonResult OneClickApply(int id)
        {
            Application ctx = new Application();
            Position position = db.Positions.Find(id);
            OpenPosition open = db.OpenPositions.Where(op => op.PositionID == id).FirstOrDefault();
            //open.PositionID = open.OpenPositionID;

            string userID = User.Identity.GetUserId();
            UserDetail currentUser = db.UserDetails.Where(ud => ud.UserID == userID).FirstOrDefault();


            ctx.OpenPositionID = open.OpenPositionID;
            ctx.UserID = currentUser.UserID;
            ctx.ApplicationDate = DateTime.Today.Date;
            ctx.ResumeFileName = currentUser.ResumeFileName;
            ctx.ApplicationStatusID = 1;
            db.Applications.Add(ctx);
            db.SaveChanges();
            string confirmMessage = string.Format("You have just applied for '{0}'!", open.Position.Title);
            
            return Json(new { id = id, message = confirmMessage});
        }
        //[HttpPost]
        //public ActionResult Button()
        //{
        //    string userID = User.Identity.GetUserId();
        //    UserDetail currentUser = db.UserDetails.Where(ud => ud.UserID == userID).FirstOrDefault();
        //    var apps = db.Applications.Where(a => a.ResumeFileName == currentUser.ResumeFileName);

        //    var opps = db.Positions.Include(o => o.JobDescription).Include(p => p.PositionID);

        //    List<int> appliedPos = new List<int>();
        //    foreach (var item in apps)
        //    {
        //        foreach (var op in opps)
        //        {
        //            if (item.OpenPosition.PositionID == op.PositionID)
        //            {
        //                appliedPos.Add(op.PositionID);
        //            }
        //        }
        //    }
        //    return ViewBag.AppliedOP = appliedPos;
        //}

       
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
