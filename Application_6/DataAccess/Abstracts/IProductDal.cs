using Entities.Concretes;

namespace DataAccess.Abstracts
{
    public interface IProductDal:IEntityRepository<Product>
    {
        List<Product> GetByName(string name);
        List<Product> GetByPrice(double price);
        List<Product> GetByQuantity(int quantity);
        List<Product> GetByCategoryId(int id);
        List<Product> GetByDiscontinued(bool discontinued);

    }
}
