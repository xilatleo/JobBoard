using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using JobBoard.DATA.EF;
using PagedList;
using PagedList.Mvc;
using Microsoft.AspNet.Identity;

namespace JobBoard.UI.MVC.Controllers
{
    public class OpenPositionsController : Controller
    {
        private JobBoardSiteEntities db = new JobBoardSiteEntities();

        // GET: OpenPositions
        public ActionResult Index(string searchString, string currentFilter, int page = 1)
        {

            if (User.Identity.IsAuthenticated)
            {
                string user = User.Identity.GetUserId();
                UserDetail currentUser = db.UserDetails.Where(ud => ud.UserID == user).FirstOrDefault();

                var apps = db.Applications.Where(app => app.UserID == currentUser.UserID);
                var op = db.OpenPositions.Include(a => a.Location).Include(a => a.Position);

                List<int> appliedPos = new List<int>();

                foreach (var a in apps)
                {
                    foreach (var b in op)
                    {
                        if (a.OpenPositionID == b.OpenPositionID)
                        {
                            appliedPos.Add(b.OpenPositionID);
                        }
                    }
                }
                ViewBag.AppliedPosition = appliedPos;
                
            }
          




            int pageSize = 5;
            var position = db.OpenPositions.ToList();
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
                            where p.Position.Title.ToLower().Contains(searchString.ToLower())

                            select p).ToList();
            }
            ViewBag.CurrentFilter = searchString;
            
            return View(position.ToPagedList(page, pageSize));
        }

       


        // GET: OpenPositions/Details/5
        public ActionResult Details(int? id)
        {
            if (User.Identity.IsAuthenticated)
            {
                string user = User.Identity.GetUserId();
                UserDetail currentUser = db.UserDetails.Where(ud => ud.UserID == user).FirstOrDefault();

                var apps = db.Applications.Where(app => app.UserID == currentUser.UserID);
                var op = db.OpenPositions.Include(a => a.Location).Include(a => a.Position);

                List<int> appliedPos = new List<int>();

                foreach (var a in apps)
                {
                    foreach (var b in op)
                    {
                        if (a.OpenPositionID == b.OpenPositionID)
                        {
                            appliedPos.Add(b.OpenPositionID);
                        }
                    }
                }
                ViewBag.AppliedPosition = appliedPos;

            }
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            OpenPosition openPosition = db.OpenPositions.Find(id);
            if (openPosition == null)
            {
                return RedirectToAction("OpenPositionsError", "CustomError");
            }
            return View(openPosition);
        }

        // GET: OpenPositions/Create
        [Authorize(Roles = "Admin, Manager")]
        public ActionResult Create()
        {
            ViewBag.LocationID = new SelectList(db.Locations, "LocationID", "StoreNumber");
            ViewBag.PositionID = new SelectList(db.Positions, "PositionID", "Title");
            return View();
        }

        // POST: OpenPositions/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "OpenPositionID,PositionID,LocationID,Title,JobDescription")] OpenPosition openPosition, Position position)
        {
            if (ModelState.IsValid)
            {


                db.Positions.Add(position);
                db.OpenPositions.Add(openPosition);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.LocationID = new SelectList(db.Locations, "LocationID", "StoreNumber", openPosition.LocationID);
            ViewBag.PositionID = new SelectList(db.Positions, "PositionID", "Title", openPosition.PositionID);
            return View(openPosition);
        }

        // GET: OpenPositions/Edit/5
        [Authorize(Roles = "Admin, Manager")]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            OpenPosition openPosition = db.OpenPositions.Find(id);
            if (openPosition == null)
            {
                return HttpNotFound();
            }
            ViewBag.LocationID = new SelectList(db.Locations, "LocationID", "StoreNumber", openPosition.LocationID);
            ViewBag.PositionID = new SelectList(db.Positions, "PositionID", "Title", openPosition.PositionID);
            return View(openPosition);
        }

        // POST: OpenPositions/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "OpenPositionID,PositionID,LocationID")] OpenPosition openPosition)
        {
            if (ModelState.IsValid)
            {
                db.Entry(openPosition).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.LocationID = new SelectList(db.Locations, "LocationID", "StoreNumber", openPosition.LocationID);
            ViewBag.PositionID = new SelectList(db.Positions, "PositionID", "Title", openPosition.PositionID);
            return View(openPosition);
        }

        // GET: OpenPositions/Delete/5
        [Authorize(Roles = "Admin, Manager")]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            OpenPosition openPosition = db.OpenPositions.Find(id);
            if (openPosition == null)
            {
                return HttpNotFound();
            }
            return View(openPosition);
        }

        // POST: OpenPositions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            OpenPosition openPosition = db.OpenPositions.Find(id);
            db.OpenPositions.Remove(openPosition);
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

            return Json(new { id = id, message = confirmMessage });
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult savedJob(int id)
        {
            SavedJob s = new SavedJob();
            Position position = db.Positions.Find(id);
           
            s.PositionID = position.PositionID;
          
            string userID = User.Identity.GetUserId();
            UserDetail currentUser = db.UserDetails.Where(ud => ud.UserID == userID).FirstOrDefault();


            s.Title = position.Title;
            s.UserID = currentUser.UserID;
           
            db.SavedJobs.Add(s);
            
                              
            db.SaveChanges();
            string confirmMessage = string.Format("You have just saved '{0}'!", position.Title);
            return Json(new { id = id, message = confirmMessage });
        }
      


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
