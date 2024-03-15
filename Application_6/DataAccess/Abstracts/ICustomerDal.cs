using Entities.Concretes;

namespace DataAccess.Abstracts
{
    public interface ICustomerDal:IEntityRepository<Customer>
    {
        Customer GetByNumber(string number);
        List<Customer> GetByCustomerType(CustomerType customerType);
        List<Customer> GetByCity(string city);
        List<Customer> GetByCountry(string country);
        List<Customer> GetByRegion(string region);
        List<Customer> GetByPostalCode(string postalCode);
    }
}
