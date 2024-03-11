using Application_4.Entities.Concretes;

namespace Application_4.DataAccess.Abstracts
{
    public interface IProductDal:IEntityRepository<Product>
    {
        List<Product> GetByPrice(double price);
        List<Product> GetByCategoryId(int id);
        List<Product> GetByQuantity(int quantity);
        int GetCount();
        void ApplyTax(double rate);

    }
}
