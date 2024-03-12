using Application_5.Entities.Concretes;

namespace Application_5.DataAccess.Abstracts
{
    public interface ICustomerDal:IEntityRepository<Customer>
    {
        List<Customer> GetByCustomerType(CustomerType type);
        List<Customer> GetByAddress(string address);
    }
}
