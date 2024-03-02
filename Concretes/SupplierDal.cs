using DataAccess.Abstracts;
using Entities.Concretes;
using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;
using Entities.Abstracts;

namespace DataAccess.Concretes;

public class SupplierDal : ISupplierDal
{
    public void Add(Supplier entity)
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

    public Supplier Get(int id)
    {
        using ApplicationDbContext db = new();
        return db.Suppliers.Where(x => x.SupplierID == id).SingleOrDefault();
    }

    public List<Supplier> GetAll(Expression<Func<Supplier, bool>> filter = null)
    {
        using ApplicationDbContext db = new();
        return filter == null ?
            [.. db.Suppliers] :
            [.. db.Suppliers.Where(filter)];
    }

    public void Update(Supplier entity)
    {
        using ApplicationDbContext db = new();
        db.Entry(entity).State = EntityState.Modified;
        db.SaveChanges();
    }
}
