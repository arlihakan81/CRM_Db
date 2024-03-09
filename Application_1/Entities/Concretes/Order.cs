using Application_1.Entities.Abstracts;

namespace Application_1.Entities.Concretes
{
    public class Order:IEntity
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public Product Product { get; set; }
        public int CustomerId { get; set; }
        public Customer Customer { get; set; }
        
        public DateTime OrderDate { get; set; }
         
        public OrderState State { get; set; }

    }

    public enum OrderState
    {
        Approved,
        Cancelled,
        Pending
    }
}
