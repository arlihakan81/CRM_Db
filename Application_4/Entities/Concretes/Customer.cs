using Application_4.Entities.Abstracts;

namespace Application_4.Entities.Concretes
{
    public class Customer:IEntity
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime Date_ { get; set; }
        public string Address { get; set; }

    }
}
