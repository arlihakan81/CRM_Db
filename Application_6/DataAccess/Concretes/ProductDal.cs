using Microsoft.EntityFrameworkCore;
using DataAccess.Abstracts;
using Entities.Concretes;

namespace DataAccess.Concretes
{
    public class ProductDal : IProductDal
    {
        public void Add(Product entity)
        {
            DataContext context = new();
            context.Entry(entity).State = EntityState.Added;
            context.SaveChanges();
        }

        public void Delete(int id)
        {
            using DataContext context = new();
            var uid = context.Products.Single(x => x.Id == id);
            context.Entry(uid).State = EntityState.Deleted;
            context.SaveChanges();
        }

        public List<Product> GetAll()
        {
            using DataContext context = new();
            return [.. context.Products];
        }

        public List<Product> GetByCategoryId(int id)
        {
            using DataContext context = new();
            return [.. context.Products.Include(x=>x.Category).Where(x=>x.CategoryId==id)];
        }

        public List<Product> GetByDate(DateTime date)
        {
            using DataContext context = new();
            return [.. context.Products.Include(x => x.Category).Where(x => x.Date_ == date)];
        }

        public List<Product> GetByDiscontinued(bool discontinued)
        {
            using DataContext context = new();
            return [.. context.Products.Include(x => x.Category).Where(x => x.Discontinued == discontinued)];
        }

        public Product GetById(int id)
        {
            using DataContext context = new();
            return context.Products.Single(x => x.Id == id);
        }

        public List<Product> GetByName(string name)
        {
            using DataContext context = new();
            return [.. context.Products.Include(x => x.Category).Where(x => x.Name == name)];
        }

        public List<Product> GetByPrice(double price)
        {
            using DataContext context = new();
            return [.. context.Products.Include(x => x.Category).Where(x => x.Price == price)];
        }

        public List<Product> GetByQuantity(int quantity)
        {
            using DataContext context = new();
            return [.. context.Products.Include(x => x.Quantity == quantity)];
        }

        public void Update(Product entity, int id)
        {
            using DataContext context = new();
            var uid = context.Products.Single(x => x.Id == id);
            uid.Number = entity.Number;
            uid.Name = entity.Name;
            uid.Description = entity.Description;
            uid.Price = entity.Price;
            uid.Quantity = entity.Quantity;
            uid.CategoryId = entity.CategoryId;
            uid.Date_ = entity.Date_;
            uid.Discontinued = entity.Discontinued;
            context.Entry(uid).State = EntityState.Modified;
            context.SaveChanges();
        }
    }
}
