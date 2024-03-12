using Application_5.DataAccess.Abstracts;
using Application_5.DataAccess.Concretes;
using Application_5.Entities.Concretes;
using System.Linq.Expressions;

namespace Application_5.Business.Concretes
{
    public class CustomerManager
    {
        private ICustomerDal _customerDal;

        public CustomerManager(ICustomerDal customerDal)
        {
            _customerDal = customerDal;
        }

        public void Add(Customer entity)
        {
            _customerDal.Add(entity);
        }

        public void Delete(int id)
        {
            _customerDal.Delete(id);
        }

        public List<Customer> GetAll(Expression<Func<Customer, bool>> filter = null)
        {
            return _customerDal.GetAll(filter);
        }

        public List<Customer> GetByAddress(string address)
        {
            return _customerDal.GetByAddress(address);
        }

        public List<Customer> GetByCustomerType(CustomerType type)
        {
            return _customerDal.GetByCustomerType(type);
        }

        public List<Customer> GetByDate(DateTime date)
        {
            return _customerDal.GetByDate(date);
        }

        public Customer GetById(int id)
        {
            return _customerDal.GetById(id);
        }

        public List<Customer> GetByName(string name)
        {
            return _customerDal.GetByName(name);
        }

        public void Update(Customer entity, int id)
        {
            _customerDal.Update(entity, id);
        }
    }
}
