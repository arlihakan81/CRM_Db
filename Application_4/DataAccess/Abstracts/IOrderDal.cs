using Application_4.Entities.Concretes;

namespace Application_4.DataAccess.Abstracts
{
    public interface IOrderDal:IEntityRepository<Order>
    {
        List<Order> GetByDate(DateTime date);
        List<Order> GetByState(OrderState state);
        List<Order> GetByProductId(int id);
        List<Order> GetByPaymentType(PaymentType paymentType);
        List<Order> GetByCustomerId(int id);
        void CalculateOrderPrice(double price);
        double GetTotalPrice();
    }
}
