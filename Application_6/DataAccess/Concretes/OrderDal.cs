using Microsoft.EntityFrameworkCore;
using DataAccess.Abstracts;
using Entities.Concretes;

namespace DataAccess.Concretes
{
    public class OrderDal : IOrderDal
    {
        public void Add(Order entity)
        {
            using DataContext context = new();
            context.Entry(entity).State = EntityState.Added;
            context.SaveChanges();
        }

        public void Delete(int id)
        {
            using DataContext context = new();
            var uid = context.Orders.Single(x => x.Id == id);
            context.Entry(uid).State = EntityState.Deleted;
            context.SaveChanges();
        }

        public List<Order> GetAll()
        {
            using DataContext context = new();
            return [.. context.Orders.Include(x => x.Customer).Include(x => x.Shipper)];
        }

        public List<Order> GetByCustomerId(int id)
        {
            using DataContext context = new();
            return [.. context.Orders.Include(x=>x.Customer).Include(x => x.Shipper).Where(x=>x.Id==id)];
        }

        public List<Order> GetByDate(DateTime date)
        {
            using DataContext context = new();
            return [.. context.Orders.Include(x => x.Customer).Include(x => x.Shipper).Where(x => x.Date_ == date)];
        }

        public Order GetById(int id)
        {
            using DataContext context = new();
            return context.Orders.Include(x => x.Customer).Include(x => x.Shipper).Single(x => x.Id == id);
        }

        public Order GetByNumber(string number)
        {
            using DataContext context = new();
            return context.Orders.Include(x => x.Customer).Include(x => x.Shipper).Single(x => x.Number == number);
        }

        public List<Order> GetByOrderDate(DateTime date)
        {
            using DataContext context = new();
            return [.. context.Orders.Include(x => x.Customer).Include(x => x.Shipper).Where(x=>x.OrderDate==date)];
        }

        public List<Order> GetByPayment(OrderPayment payment)
        {
            using DataContext context = new();
            return [.. context.Orders.Include(x => x.Customer).Include(x => x.Shipper).Where(x => x.Payment == payment)];
        }

        public List<Order> GetByRequiredDate(DateTime date)
        {
            using DataContext context = new();
            return [.. context.Orders.Include(x => x.Customer).Include(x => x.Shipper).Where(x => x.RequiredDate == date)];
        }

        public List<Order> GetByShippedDate(DateTime date)
        {
            using DataContext context = new();
            return [.. context.Orders.Include(x => x.Customer).Include(x => x.Shipper).Where(x => x.ShippedDate == date)];
        }

        public List<Order> GetByShipperId(int id)
        {
            using DataContext context = new();
            return [.. context.Orders.Include(x => x.Customer).Include(x => x.Shipper).Where(x => x.ShipperId == id)];
        }

        public List<Order> GetByState(OrderState state)
        {
            using DataContext context = new();
            return [.. context.Orders.Include(x => x.Customer).Include(x => x.Shipper).Where(x => x.State == state)];
        }

        public void Update(Order entity, int id)
        {
            using DataContext context = new();
            var uid = context.Orders.Single(x => x.Id == id);
            uid.Number = entity.Number;
            uid.CustomerId = entity.CustomerId;
            uid.OrderDate = entity.OrderDate;
            uid.RequiredDate = entity.RequiredDate;
            uid.ShippedDate = entity.ShippedDate;
            uid.State = entity.State;
            uid.Payment = entity.Payment;
            uid.ShipperId = entity.ShipperId;
            uid.Date_ = entity.Date_;
            context.Entry(uid).State = EntityState.Modified;
            context.SaveChanges();
        }
    }
}
