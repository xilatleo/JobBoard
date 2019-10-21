using JobBoard.UI.MVC.Models;
using System;
using System.Net;
using System.Net.Mail;
using System.Web.Mvc;

namespace JobBoard.UI.MVC.Controllers
{
    public class HomeController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        [Authorize]
        public ActionResult About()
        {
            ViewBag.Message = "Your app description page.";

            return View();
        }

        [HttpGet]
        public ActionResult Contact()
        {


            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Contact(ContactViewModel cvm)
        {
            //make sure the object passes validation if not return to the viwe with the data
            if (!ModelState.IsValid)
            {
                return View(cvm);
            }

            //Pass: Build the message that represent the body of MailMessage
            string message = $"You have received and email from {cvm.Name} with a subject of {cvm.Subject}. Please respond to {cvm.Email} with your response to the following message: <br/>{cvm.Message}";

            //Create the MailMesage object (from, to subject, body) System.Net.Mail
            MailMessage mm = new MailMessage(
                "admin@quancoder.com",
                "quan.h.trinh@outlook.com",
                cvm.Subject,
                message);

            //allow for HTML in the message
            mm.IsBodyHtml = true;

            //mark with high priority (this is not a require step)
            mm.Priority = MailPriority.High;

            //Set the ReplyToList to reply to the user NOT our email address (default)
            mm.ReplyToList.Add(cvm.Email);

            //smtp client
            SmtpClient client = new SmtpClient("mail.quancoder.com");

            //Client Credentials - System.Net;
            client.Credentials = new NetworkCredential("admin@quancoder.com", "yourpasswordhere!");

            //Try
            try
            {
                //send email
                client.Send(mm);
            }
            catch (Exception ex)
            {
                //code the viewbag object
                ViewBag.CustomerMessage =
                    $"We're sorry your request could not be completed at this time. Please try again later. Error Message: <br/>{ex.StackTrace}";

                //return the form filled out
                return View(cvm);
            }

            //if all goes well return the confirmation view with the object
            return View("EmailConfirmation", cvm);
        }

        [Authorize]
        public ActionResult AdminPanel()
        {
            return View();
        }
      
    }
}
