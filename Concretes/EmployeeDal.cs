using DataAccess.Abstracts;
using Entities.Concretes;
using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;

namespace DataAccess.Concretes;

public class EmployeeDal : IEmployeeDal
{
    public void Add(Employee entity)
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

    public Employee Get(int id)
    {
        using ApplicationDbContext db = new();
        return db.Employees.Where(x => x.EmployeeID == id).SingleOrDefault();
    }

    public List<Employee> GetAll(Expression<Func<Employee, bool>> filter = null)
    {
        using ApplicationDbContext db = new();
        return filter == null ? [.. db.Employees] : [.. db.Employees.Where(filter)];
    }

    public void Update(Employee entity)
    {
        using ApplicationDbContext db = new();
        db.Entry(entity).State = EntityState.Modified;
        db.SaveChanges();
    }
}
