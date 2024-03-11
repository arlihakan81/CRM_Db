using Application_4.DataAccess.Abstracts;
using Application_4.Entities.Concretes;

namespace Application_4.DataAccess.Concretes
{
    public class OrderDal : IOrderDal
    {
        public List<Order> _orders = [];
        public OrderDal()
        {
            _orders.Add(new Order { Id=1, CustomerId=5, ProductId=3, Quantity=3, State=OrderState.Completed, PaymentType=PaymentType.CreditCard, Date_=DateTime.Parse("11.02.2022") });
            _orders.Add(new Order { Id=2, CustomerId=3, ProductId=4, Quantity=5, State=OrderState.Completed, PaymentType=PaymentType.CreditCard, Date_=DateTime.Parse("09.03.2022") });
            _orders.Add(new Order { Id=3, CustomerId=4, ProductId=5, Quantity=6, State=OrderState.Approved, PaymentType=PaymentType.Transfer, Date_=DateTime.Parse("21.03.2022") });
            _orders.Add(new Order { Id=4, CustomerId=1, ProductId=2, Quantity=2, State=OrderState.Pending, PaymentType=PaymentType.Cash, Date_=DateTime.Parse("18.03.2022") });
            _orders.Add(new Order { Id=5, CustomerId=1, ProductId=2, Quantity=2, State=OrderState.Approved, PaymentType=PaymentType.Cash, Date_=DateTime.Parse("08.04.2022") });
            _orders.Add(new Order { Id=6, CustomerId=1, ProductId=2, Quantity=2, State=OrderState.Pending, PaymentType=PaymentType.Cash, Date_=DateTime.Parse("15.04.2022") });
        }
        public void Add(Order entity)
        {
            _orders.Add(entity);            
        }

        public void Delete(int id)
        {
            Order item = _orders[id];
            _orders.Remove(item);
        }

        public List<Order> GetAll()
        {
            return _orders;
        }

        public List<Order> GetByCustomerId(int id)
        {
            return [.. _orders.Where(x => x.CustomerId == id)];
        }

        public List<Order> GetByDate(DateTime date)
        {
            return [.. _orders.Where(x=>x.Date_ == date)];
        }

        public Order GetById(int id)
        {
            return _orders[id];
        }

        public List<Order> GetByPaymentType(PaymentType paymentType)
        {
            return [.. _orders.Where(x=>x.PaymentType==paymentType)];
        }

        public List<Order> GetByProductId(int id)
        {
            return [.. _orders.Where(x => x.ProductId == id)];
        }

        public List<Order> GetByState(OrderState state)
        {
            return [.. _orders.Where(x => x.State == state)];
        }
       
        public void CalculateOrderPrice(double price)
        {   
            foreach (Order item in _orders)
            {
                item.TotalPrice += price * item.Quantity;
            }
        }

        public double GetTotalPrice()
        {
            return _orders.Sum(x => x.TotalPrice);
        }

    }
}
