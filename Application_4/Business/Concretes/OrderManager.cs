using Application_4.DataAccess.Abstracts;
using Application_4.Entities.Concretes;

namespace Application_4.Business.Concretes
{
    public class OrderManager
    {
        private IOrderDal _orderDal;
        public OrderManager(IOrderDal orderDal) 
        {
            _orderDal = orderDal;
        }

        public void Add(Order entity)
        {
            _orderDal.Add(entity);
        }

        public void Delete(int id)
        {
            _orderDal.Delete(id);
        }

        public List<Order> GetAll()
        {
            return _orderDal.GetAll();
        }

        public List<Order> GetByCustomerId(int id)
        {
            return _orderDal.GetByCustomerId(id);
        }

        public List<Order> GetByDate(DateTime date)
        {
            return _orderDal.GetByDate(date);
        }

        public Order GetById(int id)
        {
            return _orderDal.GetById(id);
        }

        public List<Order> GetByPaymentType(PaymentType paymentType)
        {
            return _orderDal.GetByPaymentType(paymentType);
        }

        public List<Order> GetByProductId(int id)
        {
            return _orderDal.GetByProductId(id);
        }

        public List<Order> GetByState(OrderState state)
        {
            return _orderDal.GetByState(state);
        }

        public void CalculateOrderPrice(double price)
        {
            _orderDal.CalculateOrderPrice(price);
        }

        public double GetTotalPrice()
        {
            return _orderDal.GetTotalPrice();
        }
    }
}
