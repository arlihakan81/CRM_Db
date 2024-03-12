using Application_5.DataAccess.Abstracts;
using Application_5.Entities.Concretes;
using System.Linq.Expressions;

namespace Application_5.Business.Concretes
{
    public class AccountManager
    {
        private IAccountDal _accountDal;
        public AccountManager(IAccountDal accountDal) 
        {
            _accountDal = accountDal;
        }

        public void Add(Account entity)
        {
            _accountDal.Add(entity);
        }

        public void Delete(int id)
        {
            _accountDal.Delete(id);
        }

        public List<Account> GetAll(Expression<Func<Account, bool>> filter = null)
        {
            return _accountDal.GetAll(filter);
        }

        public List<Account> GetByDate(DateTime date)
        {
            return _accountDal.GetByDate(date);
        }

        public Account GetById(int id)
        {
            return _accountDal.GetById(id);
        }

        public List<Account> GetByName(string name)
        {
            return _accountDal.GetByName(name);
        }

        public void Update(Account entity, int id)
        {
            _accountDal.Update(entity, id);
        }

        public List<Account> GetByCustomerId(int id)
        {
            return _accountDal.GetByCustomerId(id);
        }

        public List<Account> GetByTotalLimit(double limit)
        {
            return _accountDal.GetByTotalLimit(limit);
        }

        public List<Account> GetByUsableLimit(double limit)
        {
            return _accountDal.GetByUsableLimit(limit);
        }

    }
}
