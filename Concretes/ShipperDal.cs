using DataAccess.Abstracts;
using Entities.Concretes;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace DataAccess.Concretes;

public class ShipperDal : IShipperDal
{
    public void Add(Shipper entity)
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

    public Shipper Get(int id)
    {
        using ApplicationDbContext db = new();
        return db.Shippers.Where(x => x.ShipperID == id).SingleOrDefault();
    }

    public List<Shipper> GetAll(Expression<Func<Shipper, bool>> filter = null)
    {
        using ApplicationDbContext db = new();
        return filter == null ?
            [.. db.Shippers] :
            [.. db.Shippers.Where(filter)];
    }

    public void Update(Shipper entity)
    {
        using ApplicationDbContext db = new();
        db.Entry(entity).State = EntityState.Modified;
        db.SaveChanges();
    }
}
