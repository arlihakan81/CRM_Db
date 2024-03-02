using Entities.Concretes;

namespace DataAccess.Abstracts;

public interface IOrderDal:IEntityRepository<Order>
{
    void Delete(int id);
    Order Get(int id);
}
