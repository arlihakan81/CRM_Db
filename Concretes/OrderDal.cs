using DataAccess.Abstracts;
using Entities.Concretes;
using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;

namespace DataAccess.Concretes;

public class OrderDal : IOrderDal
{
    public void Add(Order entity)
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

    public Order Get(int id)
    {
        using ApplicationDbContext db = new();
        return db.Orders.Where(x=>x.OrderID == id).SingleOrDefault();
    }

    public List<Order> GetAll(Expression<Func<Order, bool>> filter = null)
    {
        using ApplicationDbContext db = new();
        return filter == null ? 
        [.. db.Orders
            .Include(x=>x.Customer)
            .Include(x=>x.Employee)
            .Include(x=>x.Shipper)] : 
        [.. db.Orders
            .Include(x => x.Customer)
            .Include(x => x.Employee)
            .Include(x => x.Shipper)
        .Where(filter)];
    }

    public void Update(Order entity)
    {
        using ApplicationDbContext db = new();
        db.Entry(entity).State = EntityState.Modified;
        db.SaveChanges();
    }
}
