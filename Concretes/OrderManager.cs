using DataAccess.Abstracts;
using System.Linq.Expressions;
using Entities.Concretes;

namespace Business.Concretes;

public class OrderManager
{
    private readonly IOrderDal _orderDal;

    public OrderManager(IOrderDal orderDal)
    {
        _orderDal = orderDal;
    }

    public List<Order> GetAll(Expression<Func<Order, bool>> filter=null)
    {
        return _orderDal.GetAll(filter);
    }

    public Order Get(int id)
    {
        return _orderDal.Get(id);
    }

    public void Add(Order order)
    {
        _orderDal.Add(order);
    }

    public void Update(Order order)
    {
        _orderDal.Update(order);
    }

    public void Delete(int id)
    {
        _orderDal.Delete(id);
    }


}
