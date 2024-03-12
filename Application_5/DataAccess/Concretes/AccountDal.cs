using Application_5.DataAccess.Abstracts;
using Application_5.Entities.Concretes;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace Application_5.DataAccess.Concretes
{
    internal class AccountDal : IAccountDal
    {
        public void Add(Account entity)
        {
            using DataContext db = new();
            db.Accounts.Add(entity);
            db.SaveChanges();
        }

        public void Delete(int id)
        {
            using DataContext db = new();
            db.Accounts.Remove(db.Accounts.Where(x=>x.Id==id).Single());
            db.SaveChanges();
        }

        public List<Account> GetAll(Expression<Func<Account, bool>> filter = null)
        {
            using DataContext db = new();
            return filter == null ? [.. db.Accounts
                .Include(x=>x.Customer)
                ] 
            
            : [.. db.Accounts.Where(filter)];
        }

        public List<Account> GetByCustomerId(int id)
        {
            using DataContext db = new();
            return [.. db.Accounts.Include(x=>x.Customer).Where(x => x.CustomerId==id)];
        }

        public List<Account> GetByDate(DateTime date)
        {
            using DataContext db = new();
            return [.. db.Accounts.Include(x=>x.Customer).Where(x => x.Date_ == date)];
        }

        public Account GetById(int id)
        {
            using DataContext db = new();
            return db.Accounts.FirstOrDefault(x => x.Id==id);
        }

        public List<Account> GetByName(string name)
        {
            using DataContext db = new();
            return [.. db.Accounts.Include(x=>x.Customer).Where(x => x.Name == name)];
        }

        public List<Account> GetByTotalLimit(double limit)
        {
            using DataContext db = new();
            return [.. db.Accounts.Include(x=>x.Customer).Where(x => x.Limit == limit)];
        }

        public List<Account> GetByUsableLimit(double limit)
        {
            using DataContext db = new();
            return [.. db.Accounts.Where(x=>x.UsableLimit==limit)];
        }

        public void Update(Account entity, int id)
        {
            using DataContext db = new();
            var uid = db.Accounts.Single(x => x.Id == id);
            uid.Number = entity.Number;
            uid.Name = entity.Name;
            uid.CustomerId = entity.CustomerId;
            uid.Limit = entity.Limit;
            uid.MaxLimit = entity.MaxLimit;
            uid.UsableLimit = entity.UsableLimit;
            uid.Iban = entity.Iban;
            uid.Date_ = entity.Date_;
            db.Entry(uid).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
            db.SaveChanges();
        }
    }
}
