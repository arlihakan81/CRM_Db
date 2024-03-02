using DataAccess.Abstracts;
using Entities.Concretes;
using System.Linq.Expressions;

namespace Business.Concretes;

public class CustomerManager
{
    private readonly ICustomerDal _customerDal;

    public CustomerManager(ICustomerDal customerDal)
    {
        _customerDal = customerDal;
    }

    public List<Customer> GetAll(Expression<Func<Customer,bool>> filter=null)
    {
        return _customerDal.GetAll(filter);
    }

    public Customer Get(string id)
    {
        return _customerDal.Get(id);
    }

    public void Add(Customer customer)
    {
        _customerDal.Add(customer);
    }

    public void Update(Customer customer)
    {
        _customerDal.Update(customer);
    }

    public void Delete(string id)
    {
        _customerDal.Delete(id);
    }


}
