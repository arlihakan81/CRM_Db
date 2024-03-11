using Application_4.Entities.Abstracts;

namespace Application_4.Entities.Concretes
{
    public class Order:IEntity
    {
        public int Id { get; set; }
        public int CustomerId { get; set; }
        public Customer Customer { get; set; }
        public int ProductId { get; set; }
        public Product Product { get; set; }
        public int Quantity { get; set; }
        public double TotalPrice { get; set; }
        public DateTime Date_ { get; set; }
        public PaymentType PaymentType { get; set; }
        public OrderState State { get; set; }
    }

    public enum OrderState { Unpaid, Cancelled, Approved, Completed, Pending }
    public enum PaymentType { Transfer, Cash, Eft, CreditCard }
}
