using Karpey.AspNetCore.WebUI.DataAccess;
using Microsoft.AspNetCore.Mvc;

namespace Karpey.AspNetCore.WebUI.Controllers
{
    public class ProductController : Controller
    {
        private readonly KarpeyContext _context;

        public ProductController(KarpeyContext context)
        {
            _context = context;
        }

        [Route("Products")]
        public IActionResult Index()
        {
            
            return View(
                _context.Products.ToList()
                );
        }
    }
}
