using Entities.Concretes;

namespace DataAccess.Abstracts;

public interface ICategoryDal:IEntityRepository<Category>
{
    Category Get(int id);
    void Delete(int id);
}
