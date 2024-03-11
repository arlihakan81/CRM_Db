using Application_4.DataAccess.Abstracts;
using Application_4.Entities.Concretes;

namespace Application_4.Business.Concretes
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

        public List<Customer> GetAll()
        {
            return _customerDal.GetAll();
        }

        public List<Customer> GetByAddress(string address)
        {
            return _customerDal.GetByAddress(address);
        }

        public List<Customer> GetByDate(DateTime date)
        {
            return _customerDal.GetByDate(date);
        }

        public List<Customer> GetByFirstName(string firstName)
        {
            return _customerDal.GetByFirstName(firstName);
        }

        public Customer GetById(int id)
        {
            return _customerDal.GetById(id);
        }

        public List<Customer> GetByLastName(string lastName)
        {
            return _customerDal.GetByLastName(lastName);
        }
    }
}
