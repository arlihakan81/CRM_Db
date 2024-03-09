using Application_1.DataAccess.Abstracts;
using Application_1.Entities.Concretes;

namespace Application_1.DataAccess.Concretes
{
    public class OrderDal : IOrderDal
    {
        List<Order> _orders = [];
        public OrderDal()
        {
            _orders.Add(new Order { Id = 1, ProductId = 1, State = OrderState.Approved, OrderDate= DateTime.Parse("05.02.2024"), CustomerId=1 });
            _orders.Add(new Order { Id = 2, ProductId = 4, State = OrderState.Cancelled, OrderDate= DateTime.Parse("04.03.2024"), CustomerId=2 });
            _orders.Add(new Order { Id = 3, ProductId = 5, State = OrderState.Approved, OrderDate= DateTime.Parse("11.02.2024"), CustomerId=2 });
            _orders.Add(new Order { Id = 4, ProductId = 7, State = OrderState.Approved, OrderDate= DateTime.Parse("07.01.2024"), CustomerId=3 });
            _orders.Add(new Order { Id = 5, ProductId = 9, State = OrderState.Approved, OrderDate= DateTime.Parse("08.02.2024"), CustomerId=3 });
            _orders.Add(new Order { Id = 6, ProductId = 10, State = OrderState.Approved, OrderDate= DateTime.Parse("18.01.2024"), CustomerId=4 });
            _orders.Add(new Order { Id = 7, ProductId = 1, State = OrderState.Pending, OrderDate= DateTime.Parse("11.02.2024"), CustomerId=7 });
            _orders.Add(new Order { Id = 8, ProductId = 2, State = OrderState.Approved, OrderDate= DateTime.Parse("10.02.2024"), CustomerId=8 });
            _orders.Add(new Order { Id = 9, ProductId = 5, State = OrderState.Pending, OrderDate= DateTime.Parse("17.02.2024"), CustomerId=9 });
            _orders.Add(new Order { Id = 10, ProductId = 4, State = OrderState.Pending, OrderDate= DateTime.Parse("21.01.2024"), CustomerId=10 });
        }
        public void Add(Order entity)
        {
            _orders.Add(entity);
        }

        public void Delete(int id)
        {
            var item = _orders.Find(x => x.Id == id);
            _orders.Remove(item);
        }

        public List<Order> GetAll()
        {
            return _orders;
        }

        public Order GetById(int id)
        {
            return _orders.Where(x=>x.Equals(id)).FirstOrDefault();
        }

        public int GetOrderCount()
        {
            return _orders.Count;
        }

        public List<Order> GetOrdersByCategoryId(int id)
        {
            return _orders.Where(x=>x.Product.CategoryId==id).ToList();
        }

        public List<Order> GetOrdersByOrderDate(DateTime date)
        {
            return _orders.Where(x => x.OrderDate == date).ToList();
        }

        public List<Order> GetOrdersByOrderState(OrderState state)
        {
            return _orders.Where(x => x.State == state).ToList();
        }

        public List<Order> GetOrdersByProductId(int id)
        {
            return _orders.Where(x=>x.ProductId==id).ToList();  
        }

        public void Update(Order entity)
        {
            throw new NotImplementedException();
        }
    }
}
