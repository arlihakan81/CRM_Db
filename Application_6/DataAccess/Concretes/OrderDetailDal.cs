using Microsoft.EntityFrameworkCore;
using DataAccess.Abstracts;
using Entities.Concretes;

namespace DataAccess.Concretes
{
    public class OrderDetailDal : IOrderDetailDal
    {
        public void Add(OrderDetail entity)
        {
            using DataContext context = new();
            context.Entry(entity).State = EntityState.Added;
            context.SaveChanges();
        }

        public void Delete(int id)
        {
            using DataContext context = new();
            var uid = context.OrderDetails.Single(x => x.Id == id);
            context.Entry(uid).State = EntityState.Deleted;
            context.SaveChanges();
        }

        public List<OrderDetail> GetAll()
        {
            using DataContext context = new();
            return [.. context.OrderDetails.Include(x => x.Product).Include(x => x.Order).ThenInclude(x => x.Customer)];
        }

        public List<OrderDetail> GetByDate(DateTime date)
        {
            using DataContext context = new();
            return [.. context.OrderDetails.Include(x => x.Product).Include(x => x.Order).ThenInclude(x => x.Customer).Where(x => x.Date_ == date)];
        }

        public OrderDetail GetById(int id)
        {
            using DataContext context = new();
            return context.OrderDetails.Include(x => x.Product).Include(x => x.Order).ThenInclude(x => x.Customer).Single(x => x.Id == id);
        }

        public List<OrderDetail> GetByPrice(double price)
        {
            using DataContext context = new();
            return [.. context.OrderDetails.Include(x=>x.Product).Include(x=>x.Order).ThenInclude(x => x.Customer).Where(x=>x.Price==price)];
        }

        public List<OrderDetail> GetByProductId(int id)
        {
            using DataContext context = new();
            return [.. context.OrderDetails.Include(x => x.Product).Include(x => x.Order).ThenInclude(x => x.Customer).Where(x => x.ProductId == id)];
        }

        public List<OrderDetail> GetByQuantity(int quantity)
        {
            using DataContext context = new();
            return [.. context.OrderDetails.Include(x => x.Product).Include(x => x.Order).ThenInclude(x => x.Customer).Where(x => x.Quantity == quantity)];
        }

        public List<OrderDetail> GetByTotal(double total)
        {
            using DataContext context = new();
            return [.. context.OrderDetails.Include(x => x.Product).Include(x => x.Order).ThenInclude(x=>x.Customer).Where(x => x.Total == total)];
        }

        public int GetTotalOrderCountByOrderDate(DateTime date)
        {
            using DataContext context = new();
            return context.OrderDetails.Include(x=>x.Order).Where(x=>x.Order.OrderDate==date).Count();
        }

        public int GetTotalOrderCountByProductId(int id)
        {
            using DataContext context = new();
            return context.OrderDetails.Where(x => x.ProductId == id).Count();
        }

        public int GetTotalOrderCountByRequiredDate(DateTime date)
        {
            using DataContext context = new();
            return context.OrderDetails.Include(x => x.Order).Where(x=>x.Order.OrderDate == date).Count();
        }

        public int GetTotalOrderCountByShippedDate(DateTime date)
        {
            using DataContext context = new();
            return context.OrderDetails.Include(x => x.Order).Where(x=>x.Order.ShippedDate == date).Count();
        }

        public int GetTotalOrderCountByShipperId(int id)
        {
            using DataContext context = new();
            return context.OrderDetails.Include(x => x.Order).Where(x=>x.Order.ShipperId == id).Count();
        }

        public double GetTotalPriceByCustomerId(int id)
        {
            using DataContext context = new();
            return context.OrderDetails.Include(x => x.Order).ThenInclude(x => x.Customer).Where(x => x.Order.Customer.Id == id).Sum(x => x.Total);
        }

        public double GetTotalPriceByOrderDate(DateTime date)
        {
            using DataContext context = new();
            return context.OrderDetails.Include(x => x.Order).Where(x=>x.Order.OrderDate==date).Sum(x => x.Total);
        }

        public double GetTotalPriceByOrderId(int id)
        {
            using DataContext context = new();
            return context.OrderDetails.Where(x=>x.OrderId == id).Sum(x => x.Total);
        }

        public double GetTotalPriceByOrderState(OrderState state)
        {
            using DataContext context = new();
            return context.OrderDetails.Include(x => x.Order).Where(x=>x.Order.State == state).Sum(x => x.Total);
        }

        public double GetTotalPriceByPayment(OrderPayment payment)
        {
            using DataContext context = new();
            return context.OrderDetails.Include(x => x.Order).Where(x=>x.Order.Payment == payment).Sum(x => x.Total);
        }

        public double GetTotalPriceByProductId(int id)
        {
            using DataContext context = new();
            return context.OrderDetails.Where(x => x.ProductId == id).Sum(x => x.Total);
        }

        public double GetTotalPriceByRequiredDate(DateTime date)
        {
            using DataContext context = new();
            return context.OrderDetails.Include(x => x.Order).Where(x=>x.Order.RequiredDate == date).Sum(x => x.Total);
        }

        public double GetTotalPriceByShippedDate(DateTime date)
        {
            using DataContext context = new();
            return context.OrderDetails.Include(x => x.Order).Where(x=>x.Order.ShippedDate == date).Sum(x => x.Total);
        }

        public double GetTotalPriceByShipperId(int id)
        {
            using DataContext context = new();
            return context.OrderDetails.Include(x => x.Order).Where(x=>x.Order.ShipperId == id).Sum(x => x.Total);
        }

        public void Update(OrderDetail entity, int id)
        {
            using DataContext context = new();
            var uid = context.OrderDetails.Single(x=>x.Id == id);
            uid.OrderId = entity.OrderId;
            uid.ProductId = entity.ProductId;
            uid.Price = entity.Price;
            uid.Quantity = entity.Quantity;
            uid.Total = entity.Total;
            uid.Date_ = entity.Date_;
            context.Entry(uid).State = EntityState.Modified;
            context.SaveChanges();
        }
    }
}
