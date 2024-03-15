using Entities.Concretes;

namespace DataAccess.Abstracts
{
    public interface ICategoryDal:IEntityRepository<Category>
    {
        Category GetByName(string name);
    }
}
