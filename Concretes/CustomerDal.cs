using DataAccess.Abstracts;
using Entities.Concretes;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace DataAccess.Concretes;

public class CustomerDal : ICustomerDal
{
    public void Add(Customer entity)
    {
        using ApplicationDbContext db = new();
        db.Entry(entity).State = EntityState.Added;
        db.SaveChanges();
    }

    public void Delete(string id)
    {
        using ApplicationDbContext db = new();
        db.Entry(id).State = EntityState.Deleted;
        db.SaveChanges();
    }

    public Customer Get(string id)
    {
        using ApplicationDbContext db = new();
        return db.Customers.Where(x => x.CustomerID == id).SingleOrDefault();
    }

    public List<Customer> GetAll(Expression<Func<Customer, bool>> filter = null)
    {
        using ApplicationDbContext db = new();
        return filter==null ? [.. db.Customers] : [.. db.Customers.Where(filter)];
    }

    public void Update(Customer entity)
    {
        using ApplicationDbContext db = new();
        db.Entry(entity).State = EntityState.Modified;
        db.SaveChanges();
    }
}
