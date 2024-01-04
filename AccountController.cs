using CloudinaryDotNet;
using CloudinaryDotNet.Actions;
using Karpey.AspNetCore.WebUI.DataAccess;
using Karpey.AspNetCore.WebUI.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting.Server;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing.Constraints;
using NETCore.Encrypt.Extensions;
using System.Data;
using System.Security.Claims;
using System.Security.Cryptography;
using static System.Net.Mime.MediaTypeNames;

namespace Karpey.AspNetCore.WebUI.Controllers
{
    [Authorize]
    public class AccountController : Controller
    {
        private readonly KarpeyContext _context;
        private readonly IWebHostEnvironment _webhost;

        
        public AccountController(KarpeyContext context, IWebHostEnvironment webhost)
        {
            _context = context;
            _webhost = webhost;
        }

        public string MakeMd5HashPassword(string password)
        {
            string salt = "XYZABCDEFG";
            string salted = (salt + password);
            string hashedPassword = salted.MD5();
            return hashedPassword;
        }

        [HttpGet]
        public IActionResult Dashboard()
        {
            TempData["LoggedIn"] = "Hoşgeldiniz Size hizmet verebilmek bizim adına bir mutluluktur.";
            return View();
        }

        [AllowAnonymous][HttpGet]
        public IActionResult Login()
        {
            return View();
        }

        [AllowAnonymous][HttpPost]
        public async Task<IActionResult> Login(Login model)
        {
            if(ModelState.IsValid)
            {
                User user = _context.Users.SingleOrDefault(
                    x => x.Email == model.Email && x.HashedPassword == MakeMd5HashPassword(model.Password));
                //if (user == null) return View("Error");
                if(user != null)
                {
                    List<Claim> claims = new List<Claim>();
                    claims.Add(new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()));
                    claims.Add(new Claim(ClaimTypes.Email, user.Email));
                    claims.Add(new Claim(ClaimTypes.Name, user.Name + ' ' + user.Surname));

                    ClaimsIdentity identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                    ClaimsPrincipal principal = new ClaimsPrincipal(identity);
                    await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal);
                    return RedirectToAction(nameof(Dashboard));

                }
            }
            return View(model);
        }

        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Login", "Account");
        }
        [AllowAnonymous]
        public IActionResult Register()
        {
            return View();
        }

        [AllowAnonymous][HttpPost]
        public async Task<IActionResult> Register(Register model)
        {
            if (ModelState.IsValid)
            {
                if (_context.Users.Any(u => u.Email == model.Email))
                {
                    ModelState.AddModelError(nameof(model.Email), "Bu e-posta adresi zaten kullanılıyor.");
                    View(model);
                }
                _context.Add(
                    new User { Name=model.Name, Surname=model.Surname, Email = model.Email, HashedPassword = MakeMd5HashPassword(model.Password)}
                );
                await _context.SaveChangesAsync();
                return RedirectToAction("Login", "Account");
            }
            return View(model);
        }

        [HttpGet]
        [Route("ProductList")]
        public IActionResult GetAllProduct()
        {
            return View(
                _context.Products.ToList()
                );
        }

        [HttpGet]
        public IActionResult NewProduct()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> AddProduct(Product product)
        {
            if (ModelState.IsValid)
            {
                var filePath = Path.Combine(_webhost.WebRootPath, "images");
                if (!Directory.Exists(filePath))
                {
                    Directory.CreateDirectory(filePath);
                }
                var fileName = Path.Combine(filePath, product.Image.FileName);

                using (var fileStream = new FileStream(fileName, FileMode.Create))
                {
                    await product.Image.CopyToAsync(fileStream);
                }

                product.File = product.Image.FileName;

                await _context.Products.AddAsync(
                    new Product { Name = product.Name, Description = product.Description, Price = product.Price, File=product.Image.FileName }
                    );
                await _context.SaveChangesAsync();
                TempData["success"] = "Yeni ürün başarıyla eklendi";
                return RedirectToAction("GetAllProduct", "Account");
            }
            return View(product);
        }

        [HttpGet]
        public IActionResult Update(int id)
        {
            return View(
                _context.Products.SingleOrDefault(x=>x.Id==id)
                );
        }

        [HttpPost]
        public async Task<IActionResult> Update(Product product, int id)
        {
            if(ModelState.IsValid)
            {
                if(id == product.Id)
                {
                    var filePath = Path.Combine(_webhost.WebRootPath, "images");
                    if (!Directory.Exists(filePath))
                    {
                        Directory.CreateDirectory(filePath);
                    }
                    var fileName = Path.Combine(filePath, product.Image.FileName);

                    using (var fileStream = new FileStream(fileName, FileMode.Create))
                    {
                        await product.Image.CopyToAsync(fileStream);
                    }

                    product.File = product.Image.FileName;

                    _context.Update(
                        product
                        );
                    await _context.SaveChangesAsync();
                    TempData["success"] = "Ürün başarıyla güncellendi.";
                    return RedirectToAction("GetAllProduct", "Account");
                }else
                {
                    return NotFound();
                }

            }
            return View(product);
        }

        public async Task<IActionResult> Delete(int id)
        {
            var productToDelete = _context.Products.SingleOrDefault(x => x.Id == id);
            _context.Products.Remove(productToDelete);
            await _context.SaveChangesAsync();
            TempData["success"] = "Ürün başarıyla silindi.";
            return RedirectToAction(nameof(GetAllProduct));
        }
    }
}
