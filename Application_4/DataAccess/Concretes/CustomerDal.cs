using Application_4.DataAccess.Abstracts;
using Application_4.Entities.Concretes;

namespace Application_4.DataAccess.Concretes
{
    public class CustomerDal : ICustomerDal
    {
        public List<Customer> _customers = [];
        public CustomerDal() 
        { 
            _customers.Add(new Customer { Id = 1, FirstName="Merve", LastName="Atik", Address="Istanbul", Date_=DateTime.Parse("21.05.2022") });
            _customers.Add(new Customer { Id = 2, FirstName="Faruk", LastName="Dönmez", Address="Istanbul", Date_=DateTime.Parse("18.04.2021") });
            _customers.Add(new Customer { Id = 3, FirstName="Ahmet", LastName="Soyaslan", Address="Sakarya", Date_=DateTime.Parse("07.03.2021") });
            _customers.Add(new Customer { Id = 4, FirstName="Serdar", LastName="Göçer", Address="Manisa", Date_=DateTime.Parse("09.12.2020") });
            _customers.Add(new Customer { Id = 5, FirstName="Mehmet", LastName="Ersoy", Address="Balıkesir", Date_=DateTime.Parse("11.10.2019") });
            _customers.Add(new Customer { Id = 6, FirstName="İclal", LastName="Durmaz", Address="Hatay", Date_=DateTime.Parse("01.01.2019") });
        }
        public void Add(Customer entity) 
        {
            _customers.Add(entity);
        }

        public void Delete(int id)
        {
            Customer customer = _customers[id];
            _customers.Remove(customer);
        }

        public List<Customer> GetAll()
        {
            return _customers;
        }

        public List<Customer> GetByAddress(string address)
        {
            return [.. _customers.Where(x => x.Address == address)];
        }

        public List<Customer> GetByDate(DateTime date)
        {
            return [.. _customers.Where(x => x.Date_ == date)];
        }

        public List<Customer> GetByFirstName(string firstName)
        {
            return [.. _customers.Where(x=>x.FirstName == firstName)];  
        }

        public Customer GetById(int id)
        {
            return _customers[id];
        }

        public List<Customer> GetByLastName(string lastName)
        {
            return [.. _customers.Where(x => x.LastName == lastName)];
        }
    }
}
