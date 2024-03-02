using Entities.Concretes;

namespace DataAccess.Abstracts;

public interface ISupplierDal:IEntityRepository<Supplier>
{
    Supplier Get(int id);
    void Delete(int id);
}
