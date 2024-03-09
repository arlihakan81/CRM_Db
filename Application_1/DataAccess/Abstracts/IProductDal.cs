using Application_1.Entities.Concretes;

namespace Application_1.DataAccess.Abstracts
{
    public interface IProductDal:IEntityRepository<Product>
    {
        List<Product> GetAllByCategoryId(int id);

    }
}
