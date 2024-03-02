using DataAccess.Abstracts;
using Entities.Concretes;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace DataAccess.Concretes;

public class ProductDal : IProductDal
{
    public void Add(Product entity)
    {
        using ApplicationDbContext db = new();
        db.Entry(entity).State = EntityState.Added;
        db.SaveChanges();
    }

    public void Delete(int id)
    {
        using ApplicationDbContext db = new();
        db.Entry(id).State = EntityState.Deleted;
        db.SaveChanges();
    }

    public Product Get(int id)
    {
        using ApplicationDbContext db = new();
        return db.Products.SingleOrDefault(x => x.ProductID == id);
    }

    public List<Product> GetAll(Expression<Func<Product, bool>> filter = null)
    {
        using ApplicationDbContext db = new();
        return filter==null ? [.. db.Products] : [.. db.Products.Where(filter)];
    }

    public void Update(Product entity)
    {
        using ApplicationDbContext db = new();
        db.Entry(entity).State = EntityState.Modified;
        db.SaveChanges();
    }
}
