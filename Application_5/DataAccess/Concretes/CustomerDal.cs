using Application_5.DataAccess.Abstracts;
using Application_5.Entities.Concretes;
using System.Linq.Expressions;

namespace Application_5.DataAccess.Concretes
{
    public class CustomerDal : ICustomerDal
    {
        public void Add(Customer entity)
        {
            using DataContext db = new();
            db.Customers.Add(entity);
            db.SaveChanges();
        }

        public void Delete(int id)
        {
            using DataContext db = new();
            db.Customers.Remove(db.Customers.Single(x => x.Id == id));
            db.SaveChanges();
        }

        public List<Customer> GetAll(Expression<Func<Customer, bool>> filter = null)
        {
            using DataContext db = new();
            return filter == null ? [.. db.Customers] : [.. db.Customers.Where(filter)];            
        }

        public List<Customer> GetByAddress(string address)
        {
            using DataContext db = new();
            return [.. db.Customers.Where(x => x.Address == address)];
        }

        public List<Customer> GetByCustomerType(CustomerType type)
        {
            using DataContext db = new();
            return [.. db.Customers.Where(x => x.CustomerType == type)];
        }

        public List<Customer> GetByDate(DateTime date)
        {
            using DataContext db = new();
            return [.. db.Customers.Where(x => x.Date_ == date)];
        }

        public Customer GetById(int id)
        {
            using DataContext db = new();
            return db.Customers.SingleOrDefault(x => x.Id == id);
        }

        public List<Customer> GetByName(string name)
        {
            using DataContext db = new();
            return [.. db.Customers.Where(x => x.FullName == name)];
        }

        public void Update(Customer entity, int id)
        {
            using DataContext db = new();
            var uid = db.Customers.Single(x => x.Id == id);
            uid.Number = entity.Number;
            uid.FullName = entity.FullName;
            uid.Address = entity.Address;
            uid.Phone = entity.Phone;
            uid.Email = entity.Email;
            uid.CustomerType = entity.CustomerType;
            uid.Date_ = entity.Date_;
            db.Entry(uid).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
            db.SaveChanges();
        }
    }
}
