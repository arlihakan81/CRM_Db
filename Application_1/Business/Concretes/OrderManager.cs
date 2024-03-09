using Application_1.DataAccess.Abstracts;
using Application_1.Entities.Concretes;

namespace Application_1.Business.Concretes
{
    public class OrderManager
    {
        private readonly IOrderDal _orderDal;

        public OrderManager(IOrderDal orderDal)
        {
            _orderDal = orderDal;
        }

        public void Add(Order order) 
        { 
            _orderDal.Add(order);
        }

        public void Delete(int id)
        {
            _orderDal.Delete(id);
        }

        public List<Order> GetAll()
        {
            return _orderDal.GetAll();
        }

        public Order GetById(int id)
        {
            return _orderDal.GetById(id);
        }

        public int GetOrderCount()
        {
            return _orderDal.GetOrderCount();
        }

        public List<Order> GetOrdersByCategoryId(int id)
        {
            return _orderDal.GetOrdersByCategoryId(id);
        }

        public List<Order> GetOrdersByOrderDate(DateTime date)
        {
            return _orderDal.GetOrdersByOrderDate(date);
        }

        public List<Order> GetOrdersByOrderState(OrderState state)
        {
            return _orderDal.GetOrdersByOrderState(state);
        }

        public List<Order> GetOrdersByProductId(int id)
        {
            return _orderDal.GetOrdersByProductId(id);
        }
    }
}
