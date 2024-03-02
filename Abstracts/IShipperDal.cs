using Entities.Concretes;

namespace DataAccess.Abstracts;

public interface IShipperDal:IEntityRepository<Shipper>
{
    Shipper Get(int id);
    void Delete(int id);
}
