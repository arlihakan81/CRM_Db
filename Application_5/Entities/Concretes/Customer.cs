using Application_5.Entities.Abstracts;

namespace Application_5.Entities.Concretes
{
    public class Customer:IEntity
    {
        public int Id { get; set; }
        public string Number { get; set; }
        public string FullName { get; set; }
        public CustomerType CustomerType { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public DateTime Date_ { get; set; }
    }

    public enum CustomerType { Individual, Corporate }
}
