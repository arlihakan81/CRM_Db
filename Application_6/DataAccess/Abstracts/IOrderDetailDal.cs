using Entities.Concretes;
using System.Transactions;

namespace DataAccess.Abstracts
{
    public interface IOrderDetailDal:IEntityRepository<OrderDetail>
    {
        List<OrderDetail> GetByProductId(int id);
        List<OrderDetail> GetByPrice(double price);
        List<OrderDetail> GetByQuantity(int quantity);
        List<OrderDetail> GetByTotal(double total);

        double GetTotalPriceByProductId(int id);
        double GetTotalPriceByCustomerId(int id);
        double GetTotalPriceByOrderDate(DateTime date);
        double GetTotalPriceByOrderId(int id);
        double GetTotalPriceByRequiredDate(DateTime date);
        double GetTotalPriceByShippedDate(DateTime date);
        double GetTotalPriceByShipperId(int id);
        double GetTotalPriceByOrderState(OrderState state);
        double GetTotalPriceByPayment(OrderPayment payment);
        int GetTotalOrderCountByProductId(int id);
        int GetTotalOrderCountByOrderDate(DateTime date);
        int GetTotalOrderCountByRequiredDate(DateTime date);
        int GetTotalOrderCountByShippedDate(DateTime date);
        int GetTotalOrderCountByShipperId(int id);
    }
}
