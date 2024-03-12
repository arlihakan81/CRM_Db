using Application_5.DataAccess.Abstracts;
using Application_5.Entities.Concretes;
using System.Linq.Expressions;

namespace Application_5.Business.Concretes
{
    public class CreditManager
    {
        private ICreditDal _creditDal;
        public CreditManager(ICreditDal creditDal) 
        { 
            _creditDal = creditDal;
        }

        public void Add(Credit entity)
        {
            _creditDal.Add(entity);
        }

        public void Delete(int id)
        {
            _creditDal.Delete(id);
        }

        public List<Credit> GetAll(Expression<Func<Credit, bool>> filter = null)
        {
            return _creditDal.GetAll(filter);
        }

        public List<Credit> GetByCreditType(CreditType type)
        {
            return _creditDal.GetByCreditType(type);
        }

        public List<Credit> GetByCustomerId(int id)
        {
            return _creditDal.GetByCustomerId(id);
        }

        public List<Credit> GetByDate(DateTime date)
        {
            return _creditDal.GetByDate(date);
        }

        public Credit GetById(int id)
        {
            return _creditDal.GetById(id);
        }

        public List<Credit> GetByLimit(double limit)
        {
            return _creditDal.GetByLimit(limit);
        }

        public List<Credit> GetByName(string name)
        {
            return _creditDal.GetByName(name);
        }

        public void Update(Credit entity, int id)
        {
            _creditDal.Update(entity, id);
        }

    }
}
