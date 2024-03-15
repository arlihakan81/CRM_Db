using Entities.Concretes;

namespace DataAccess.Abstracts
{
    public interface IOrderDal:IEntityRepository<Order>
    {
        Order GetByNumber(string number);
        List<Order> GetByCustomerId(int id);
        List<Order> GetByOrderDate(DateTime date);
        List<Order> GetByRequiredDate(DateTime date);
        List<Order> GetByShippedDate(DateTime date);
        List<Order> GetByState(OrderState state);
        List<Order> GetByPayment(OrderPayment payment);
        List<Order> GetByShipperId(int id);

    }
}
