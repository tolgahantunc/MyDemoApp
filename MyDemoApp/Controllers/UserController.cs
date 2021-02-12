using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Net;
using System.Web;
using System.Web.Mvc;
using MyDemoApp.Models;
using Microsoft.AspNet.Identity;

namespace MyDemoApp.Controllers
{    
    public class UserController : Controller
    {
        private MyDemoAppDBEntities db = new MyDemoAppDBEntities();

        public ActionResult Login()
        {
            if (Request.Cookies.Get("username") != null)
            {
                HttpContext.Response.SetCookie(Request.Cookies.Get("username"));
            }
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(User user)
        {
            if (ModelState.IsValid)
            {
                User u = db.User.Where(x => x.username.Equals(user.username) && x.password.Equals(user.password)).FirstOrDefault();

                if (u == null)
                {
                    //user does not exist
                    ViewBag.Message = "User does not exist or password is wrong.";
                    return View();
                }

                Session["UserName"] = u.username.ToString();

                //add cookie! remember login name
                var userCookie = new HttpCookie("username", u.username);
                HttpContext.Response.Cookies.Add(userCookie);

                return RedirectToAction("Welcome");
            }
            return View(user);
        }

        public ActionResult Welcome()
        {
            if (Session["UserName"] != null)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Login");
            }
        }

        public ActionResult ForgotPassword()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ForgotPassword(string username, string password)
        {
            if (ModelState.IsValid)
            {
                User u = db.User.Where(x => x.username.Equals(username)).FirstOrDefault();

                if (u == null)
                {
                    //user does not exist
                    ViewBag.Message = "User does not exist";
                    return View();
                }

                EmailService emailService = new EmailService();
                IdentityMessage im = new IdentityMessage();
                im.Subject = "Pasword Reminder";

                //Password should be kept as HASH in the database, but since this is not a real project, I believe it is not too important.
                im.Body = u.password;

                //I could create email field in the database, but I think it is not too important here. 
                im.Destination = $"{u.username}@tolgahantunc.com";

                try
                {
                    emailService.SendAsync(im);
                    ViewBag.Message = "Your password has been sent your e-mail address!";
                }
                catch
                {
                    ViewBag.Message = "Something went wrong! Please try again.";
                }

            }
            return View();
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
