using Application_4.Entities.Concretes;

namespace Application_4.DataAccess.Abstracts
{
    public interface ICustomerDal:IEntityRepository<Customer>
    {
        List<Customer> GetByAddress(string address);
        List<Customer> GetByDate(DateTime date);
        List<Customer> GetByFirstName(string firstName);
        List<Customer> GetByLastName(string lastName);
    }
}
