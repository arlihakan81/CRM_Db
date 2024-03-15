using Microsoft.EntityFrameworkCore;
using DataAccess.Abstracts;
using Entities.Concretes;

namespace DataAccess.Concretes
{
    public class CustomerDal : ICustomerDal
    {
        public void Add(Customer entity)
        {
            using DataContext context = new();
            context.Entry(entity).State = EntityState.Added;
            context.SaveChanges();
        }

        public void Delete(int id)
        {
            using DataContext context = new();
            var uid = context.Customers.Single(x => x.Id == id);
            context.Entry(uid).State = EntityState.Deleted;
            context.SaveChanges();
        }

        public List<Customer> GetAll()
        {
            using DataContext context = new();
            return [.. context.Customers];
        }

        public List<Customer> GetByCity(string city)
        {
            using DataContext context = new();
            return [.. context.Customers.Where(x => x.City == city)];
        }

        public List<Customer> GetByCountry(string country)
        {
            using DataContext context = new();
            return [.. context.Customers.Where(x => x.Country == country)];
        }

        public List<Customer> GetByCustomerType(CustomerType customerType)
        {
            using DataContext context = new();
            return [.. context.Customers.Where(x => x.CustomerType == customerType)];
        }

        public List<Customer> GetByDate(DateTime date)
        {
            using DataContext context = new();
            return [.. context.Customers.Where(x => x.Date_ == date)];
        }

        public Customer GetById(int id)
        {
            using DataContext context = new();
            return context.Customers.Single(x => x.Id == id);
        }

        public Customer GetByNumber(string number)
        {
            using DataContext context = new();
            return context.Customers.Single(x => x.Number == number);
        }

        public List<Customer> GetByPostalCode(string postalCode)
        {
            using DataContext context = new();
            return [.. context.Customers.Where(x=>x.PostalCode == postalCode)];
        }

        public List<Customer> GetByRegion(string region)
        {
            using DataContext context = new();
            return [.. context.Customers.Where(x => x.Region == region)];
        }

        public void Update(Customer entity, int id)
        {
            using DataContext context = new();
            var uid = context.Customers.Single(x => x.Id == id);
            uid.Number = entity.Number;
            uid.FullName = entity.FullName;
            uid.BirthDate = entity.BirthDate;
            uid.Email = entity.Email;
            uid.Address = entity.Address;
            uid.Phone = entity.Phone;
            uid.City = entity.City;
            uid.Country = entity.Country;
            uid.CustomerType = entity.CustomerType;
            uid.PostalCode = entity.PostalCode;
            uid.Region = entity.Region;
            uid.Date_ = entity.Date_;
            context.Entry(uid).State = EntityState.Modified;
            context.SaveChanges();
        }
    }
}
