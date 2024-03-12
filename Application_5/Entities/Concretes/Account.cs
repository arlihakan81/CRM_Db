using Application_5.Entities.Abstracts;

namespace Application_5.Entities.Concretes
{
    public class Account:IEntity
    {
        public int Id { get; set; }
        public string Number { get; set; }
        public string Name { get; set; }
        public int CustomerId { get; set; }
        public Customer Customer { get; set; }
        public double UsableLimit { get; set; }
        public double Limit { get; set; }
        public double MaxLimit { get; set; }
        public string Iban { get; set; }
        public DateTime Date_ { get; set; }
    }

    public enum AccountType { Bank, Credit }
}
