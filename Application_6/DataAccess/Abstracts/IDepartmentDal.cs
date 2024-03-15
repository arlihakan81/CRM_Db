using Entities.Concretes;

namespace DataAccess.Abstracts
{
    public interface IDepartmentDal:IEntityRepository<Department>
    {
        Department GetByName (string name);
    }
}
