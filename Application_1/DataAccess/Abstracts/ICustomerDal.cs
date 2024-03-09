using Application_1.Entities.Concretes;

namespace Application_1.DataAccess.Abstracts
{
    public interface ICustomerDal:IEntityRepository<Customer>
    {
        List<Customer> GetCustomerByOrderId(int id);
        List<Customer> GetCustomerByProductId(int id);
    }
}
