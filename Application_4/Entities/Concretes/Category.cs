using Application_4.Entities.Abstracts;

namespace Application_4.Entities.Concretes
{
    public class Category:IEntity
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }
}
