using Application_5.DataAccess.Abstracts;
using Application_5.Entities.Concretes;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace Application_5.DataAccess.Concretes
{
    internal class CreditDal : ICreditDal
    {
        public void Add(Credit entity)
        {
            using DataContext db = new();
            db.Credits.Add(entity);
            db.SaveChanges();
        }

        public void Delete(int id)
        {
            using DataContext db = new();
            db.Accounts.Remove(db.Accounts.Single(x => x.Id == id));
            db.SaveChanges();
        }

        public List<Credit> GetAll(Expression<Func<Credit, bool>> filter = null)
        {
            using DataContext db = new();
            return filter == null ? [.. db.Credits.Include(x=>x.Customer)] :
                [.. db.Credits.Include(x=>x.Customer).Where(filter)];
        }

        public List<Credit> GetByCreditType(CreditType type)
        {
            using DataContext db = new();
            return [.. db.Credits.Include(x=>x.Customer).Where(x => x.CreditType == type)];
        }

        public List<Credit> GetByCustomerId(int id)
        {
            using DataContext db = new();
            return [.. db.Credits.Include(x=>x.Customer).Where(x => x.CustomerId == id)];
        }

        public List<Credit> GetByDate(DateTime date)
        {
            using DataContext db = new();
            return [.. db.Credits.Include(x=>x.Customer).Where(x => x.Date_ == date)];
        }

        public Credit GetById(int id)
        {
            using DataContext db = new();
            return db.Credits.Single(x => x.Id == id);
        }

        public List<Credit> GetByLimit(double limit)
        {
            using DataContext db = new();
            return [.. db.Credits.Include(x=>x.Customer).Where(x=>x.Limit == limit)];
        }

        public List<Credit> GetByName(string name)
        {
            using DataContext db = new();
            return [.. db.Credits.Include(x=>x.Customer).Where(x=>x.Name==name)];
        }

        public void Update(Credit entity, int id)
        {
            using DataContext db = new();
            var uid = db.Credits.Single(x => x.Id == id);
            uid.Number = entity.Number;
            uid.CustomerId = entity.CustomerId;
            uid.CreditType = entity.CreditType;
            uid.Date_ = entity.Date_;
            uid.Name = entity.Name;
            uid.Limit = entity.Limit;
            uid.RateOfInterest = entity.RateOfInterest;
            uid.TotalPayback = entity.TotalPayback;
            db.Entry(uid).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
            db.SaveChanges();
        }
    }
}
