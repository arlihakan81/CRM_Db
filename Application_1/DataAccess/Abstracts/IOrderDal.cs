using Application_1.Entities.Concretes;

namespace Application_1.DataAccess.Abstracts
{
    public interface IOrderDal:IEntityRepository<Order>
    {
        List<Order> GetOrdersByProductId(int id);
        List<Order> GetOrdersByCategoryId(int id);
        int GetOrderCount();
        List<Order> GetOrdersByOrderDate(DateTime date);
        List<Order> GetOrdersByOrderState(OrderState state);
    }
}
