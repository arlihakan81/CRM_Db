using Karpey.AspNetCore.WebUI.DataAccess;
using Karpey.AspNetCore.WebUI.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using NETCore.Encrypt.Extensions;

namespace Karpey.AspNetCore.WebUI.Controllers
{
    [Authorize(Roles = "Administrator")]
    public class UserController : Controller
    {
        private readonly IWebHostEnvironment _webhost;
        private readonly KarpeyContext _context;

        public UserController(KarpeyContext context, IWebHostEnvironment webhost)
        {
            _context = context;
            _webhost = webhost;
        }
        [HttpGet]
        public IActionResult Index()
        {
            return View(_context.Users.ToList());
        }
        [HttpGet]
        public IActionResult AddUser()
        {
            return View();
        }

        public string MakeMd5HashPassword(string password)
        {
            string salt = "XYZABCDEFG";
            string salted = (salt + password);
            string hashedPassword = salted.MD5();
            return hashedPassword;
        }

        [ValidateAntiForgeryToken][HttpPost]
        public async Task<IActionResult> AddUser(Register model)
        {
            if(ModelState.IsValid)
            {
                _context.Add(
                    new User { Name=model.Name, Surname=model.Surname, Email=model.Email, HashedPassword=MakeMd5HashPassword(model.Password), Role=Role.User, ImageName="dfavatar.png" }
                    );
                await _context.SaveChangesAsync();
                return Redirect("Index");

            }
            return View(model);
        }

        [HttpGet]
        public IActionResult Update(int id)
        {
            return View(
                _context.Users.SingleOrDefault(x => x.Id == id)
                );
        }

        [HttpPost]
        public async Task<IActionResult> Update(int id, User user)
        {
            if(ModelState.IsValid)
            {
                if (id == user.Id)
                {
                    var filePath = Path.Combine(_webhost.WebRootPath, "images");
                    if (!Directory.Exists(filePath))
                    {
                        Directory.CreateDirectory(filePath);
                    }

                    var fileName = Path.Combine(filePath, user.Image.FileName);
                    using (var stream = new FileStream(fileName, FileMode.Create))
                    {
                        await user.Image.CopyToAsync(stream);
                    }
                    user.ImageName = user.Image.FileName;

                    user.HashedPassword = MakeMd5HashPassword(user.HashedPassword);
                    _context.Update(user);
                    await _context.SaveChangesAsync();
                    return RedirectToAction("Index", "User");
                }

            }

            return NotFound();

        }

        public async Task<IActionResult> Delete(int id)
        {
            var user = _context.Users.SingleOrDefault(x => x.Id == id);
            _context.Users.Remove(user);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

    }
}
