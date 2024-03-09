using Application_1.DataAccess.Abstracts;
using Application_1.Entities.Concretes;

namespace Application_1.DataAccess.Concretes
{
    public class CustomerDal : ICustomerDal
    {
        public List<Customer> _customers = [];

        public CustomerDal()
        {
            _customers.Add(new Customer { Id=1, FirstName="Tahsin", LastName="Canpolat", BirthDate=DateTime.Parse("12.01.2000")});
            _customers.Add(new Customer { Id=2, FirstName="Reşad", LastName="Soylu", BirthDate=DateTime.Parse("25.01.2001")});
            _customers.Add(new Customer { Id=3, FirstName="Faruk", LastName="Yılmaz", BirthDate=DateTime.Parse("08.02.1998")});
            _customers.Add(new Customer { Id=4, FirstName="Zeynep", LastName="Türker", BirthDate=DateTime.Parse("21.11.1985")});
            _customers.Add(new Customer { Id=5, FirstName="Kemal", LastName="Dönmez", BirthDate=DateTime.Parse("03.03.1988")});
            _customers.Add(new Customer { Id=6, FirstName="Kamil", LastName="Saymaz", BirthDate=DateTime.Parse("05.06.1995")});
            _customers.Add(new Customer { Id=7, FirstName="Hayri", LastName="Esen", BirthDate=DateTime.Parse("09.10.1987")});
            _customers.Add(new Customer { Id=8, FirstName="Meltem", LastName="Korutürk", BirthDate=DateTime.Parse("09.05.1996")});
            _customers.Add(new Customer { Id=9, FirstName="Merve", LastName="Yıldız", BirthDate=DateTime.Parse("18.01.1990")});
            _customers.Add(new Customer { Id=10, FirstName="Hamdi", LastName="Cantürk", BirthDate=DateTime.Parse("19.03.1992")});
        }

        public void Add(Customer entity)
        {
            _customers.Add(entity);
        }

        public void Delete(int id)
        {
            var item = _customers.Find(x=>x.Equals(id));
            _customers.Remove(item);
        }

        public List<Customer> GetAll()
        {
            return _customers;
        }

        public Customer GetById(int id)
        {
            return _customers.Where(x=>x.Id==id).FirstOrDefault();
        }

        public List<Customer> GetCustomerByOrderId(int id)
        {
            return _customers.Where(x=>x.Order.Id==id).ToList();
        }

        public List<Customer> GetCustomerByProductId(int id)
        {
            return _customers.Where(x=>x.Order.ProductId==id).ToList();
        }

        public void Update(Customer entity)
        {
            throw new NotImplementedException();
        }
    }
}
