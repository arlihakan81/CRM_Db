using DataAccess.Abstracts;
using Entities.Concretes;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;

namespace DataAccess.Concretes
{
    public class EmployeeDal : IEmployeeDal
    {
        public void Add(Employee entity)
        {
            using DataContext context = new ();
            context.Entry(entity).State = EntityState.Added;
            context.SaveChanges();
        }

        public void Delete(int id)
        {
            using DataContext context = new();
            Employee employee = context.Employees.SingleOrDefault(x=>x.Id==id);
            context.Entry(employee).State = EntityState.Deleted;
            context.SaveChanges();
        }

        public List<Employee> GetAll()
        {
            using DataContext context = new();
            return [.. context.Employees];
        }

        public List<Employee> GetByCity(string city)
        {
            using DataContext context = new();
            return [.. context.Employees.Include(x=>x.Department).Where(x => x.City == city)];
        }

        public List<Employee> GetByCountry(string country)
        {
            using DataContext context = new();
            return [.. context.Employees.Include(x => x.Department).Where(x => x.Country == country)];
        }

        public List<Employee> GetByDate(DateTime date)
        {
            using DataContext context = new();
            return [.. context.Employees.Include(x => x.Department).Where(x => x.Date_ == date)];
        }

        public List<Employee> GetByDepartmentId(int id)
        {
            using DataContext context = new();
            return [.. context.Employees.Include(x => x.Department).Where(x => x.DepartmentId == id)];
        }

        public List<Employee> GetByHireDate(DateTime hireDate)
        {
            using DataContext context = new();
            return [.. context.Employees.Include(x=>x.Department).Where(x=>x.HireDate == hireDate)];
        }

        public Employee GetById(int id)
        {
            using DataContext context = new();
            return context.Employees.Include(x => x.Department).Single(x => x.Id == id);
        }

        public List<Employee> GetBySalary(double salary)
        {
            using DataContext context = new();
            return [.. context.Employees.Include(x => x.Department).Where(x => x.Salary == salary)];
        }

        public List<Employee> GetByTitle(string title)
        {
            using DataContext context = new();
            return [.. context.Employees.Include(x => x.Department).Where(x => x.Title == title)];
        }

        public void Update(Employee entity, int id)
        {
            using DataContext context = new();
            var uid = context.Employees.Single(x => x.Id == id);
            uid.FirstName = entity.FirstName;
            uid.LastName = entity.LastName;
            uid.NationalId = entity.NationalId;
            uid.BirthDate = entity.BirthDate;
            uid.HireDate = entity.HireDate;
            uid.Title = entity.Title;
            uid.Address = entity.Address;
            uid.City = entity.City;
            uid.Email = entity.Email;
            uid.Phone = entity.Phone;
            uid.PostalCode = entity.PostalCode;
            uid.Country = entity.Country;
            uid.Salary = entity.Salary;
            uid.DepartmentId = entity.DepartmentId;
            uid.Date_ = entity.Date_;
            context.Entry(uid).State = EntityState.Modified;
            context.SaveChanges();
        }
    }
}
