using Application_1.DataAccess.Abstracts;
using Application_1.Entities.Concretes;

namespace Application_1.Business.Concretes
{
    public class CustomerManager
    {
        private readonly ICustomerDal _customerDal;
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

        public Customer GetById(int id)
        {
            return _customerDal.GetById(id);
        }

        public List<Customer> GetCustomerByOrderId(int id)
        {
            return _customerDal.GetCustomerByOrderId(id);
        }

        public List<Customer> GetCustomerByProductId(int id)
        {
            return _customerDal.GetCustomerByProductId(id);
        }


    }
}
