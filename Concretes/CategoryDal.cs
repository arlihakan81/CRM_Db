using DataAccess.Abstracts;
using Entities.Concretes;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace DataAccess.Concretes;

public class CategoryDal : ICategoryDal
{
    public void Add(Category entity)
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

    public Category Get(int id)
    {
        using ApplicationDbContext db = new();
        return db.Categories.Where(x=>x.CategoryID==id).SingleOrDefault();
    }

    public List<Category> GetAll(Expression<Func<Category, bool>> filter = null)
    {
        using ApplicationDbContext db = new();
        return filter == null ? [.. db.Categories] : [.. db.Categories.Where(filter)];
    }

    public void Update(Category entity)
    {
        using ApplicationDbContext db = new();
        db.Entry(entity).State = EntityState.Modified;
        db.SaveChanges();
    }
}
