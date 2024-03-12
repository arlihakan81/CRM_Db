using Application_5.Entities.Abstracts;

namespace Application_5.Entities.Concretes
{
    public class Credit:IEntity
    {
        public int Id { get; set; }
        public string Number { get; set; }
        public string Name { get; set; }
        public CreditType CreditType { get; set; }
        public int CustomerId { get; set; }
        public Customer Customer { get; set; }
        public double Limit { get; set; }
        public double RateOfInterest { get; set; }
        public double TotalPayback { get; set; }
        public DateTime Date_ { get; set; }

    }

    public enum CreditType { VehicleLoan, HousingLoan, ConsumerLoan, FarmLoan }




}
