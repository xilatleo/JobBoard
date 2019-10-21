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

namespace JobBoard.UI.MVC.Controllers
{
    public class UserDetailsController : Controller
    {
        private JobBoardSiteEntities db = new JobBoardSiteEntities();

        // GET: UserDetails
        [Authorize(Roles ="Admin,Manager")]
        public ActionResult Index()
        {
            var userDetails = db.UserDetails.Include(u => u.AspNetUser);
            return View(userDetails.ToList());
        }

        // GET: UserDetails/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UserDetail userDetail = db.UserDetails.Find(id);
            if (userDetail == null)
            {
                return HttpNotFound();
            }
            return View(userDetail);
        }

        // GET: UserDetails/Create
        [Authorize(Roles = "Admin,Manager")]
        public ActionResult Create()
        {
            ViewBag.UserID = new SelectList(db.AspNetUsers, "Id", "Email");
            return View();
        }

        // POST: UserDetails/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "UserID,FirstName,LastName,ResumeFileName")] UserDetail userDetail)
        {
            if (ModelState.IsValid)
            {
                db.UserDetails.Add(userDetail);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.UserID = new SelectList(db.AspNetUsers, "Id", "Email", userDetail.UserID);
            return View(userDetail);
        }

        // GET: UserDetails/Edit/5
       
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UserDetail userDetail = db.UserDetails.Find(id);
            if (userDetail == null)
            {
                return HttpNotFound();
            }
            ViewBag.UserID = new SelectList(db.AspNetUsers, "Id", "Email", userDetail.UserID);
            return View(userDetail);
        }

        // POST: UserDetails/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "UserID,FirstName,LastName,ResumeFileName")] UserDetail userDetail,HttpPostedFileBase fupResume)
        {
            if (ModelState.IsValid)
            {

                #region FileUpload FOR EDIT
                if (fupResume != null)
                {
                    //Get file and assign to variable
                    string resumeName = fupResume.FileName;



                    //declare and assign ext value
                    string ext = resumeName.Substring(resumeName.LastIndexOf('.'));//get the extension including '.'

                    //declare list of valid extensions
                    string[] goodExts = { ".doc", ".docx", ".pdf", ".txt" };

                    //check the ext variable in lowercase vs valid list

                    if (goodExts.Contains(ext.ToLower()) && (fupResume.ContentLength <= 4194304))
                    {
                        //if it is in the list , rename it using a GUID (Unique is vital to avoid overwrite)
                        resumeName = Guid.NewGuid() + ext;

                        //save to the webserver at correct location
                        fupResume.SaveAs(Server.MapPath("~/Content/resumes/" + resumeName));

                        //Housekeeping for edit: delete old file on record if not the default
                        if (resumeName != null)
                        {
                            System.IO.File.Delete(Server.MapPath("~/Content/images/" + resumeName));
                        }



                        //ONLY if file upload ok, change the new db record's file field to reflect
                        userDetail.ResumeFileName = resumeName;
                    }
                    else
                    {

                        userDetail.ResumeFileName = "No resume.pdf";
                        throw new ApplicationException("Incorrect file type (use PNG, JPG or GIF), or file should not exceeds 4MB)");
                    }//end if tree for good extesion and good file size


                }//end if fup exists


                #endregion
                db.Entry(userDetail).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.UserID = new SelectList(db.AspNetUsers, "Id", "Email", userDetail.UserID);
            return View(userDetail);
        }

        // GET: UserDetails/Delete/5
        [Authorize(Roles = "Admin,Manager")]
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UserDetail userDetail = db.UserDetails.Find(id);
            if (userDetail == null)
            {
                return HttpNotFound();
            }
            return View(userDetail);
        }

        // POST: UserDetails/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            UserDetail userDetail = db.UserDetails.Find(id);
            db.UserDetails.Remove(userDetail);
            db.SaveChanges();
            return RedirectToAction("Index");
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
