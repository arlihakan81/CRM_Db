using Microsoft.EntityFrameworkCore;
using DataAccess.Abstracts;
using Entities.Concretes;

namespace DataAccess.Concretes
{
    public class ShipperDal : IShipperDal
    {
        public void Add(Shipper entity)
        {
            using DataContext context = new();
            context.Entry(entity).State = EntityState.Added;
            context.SaveChanges();
        }

        public void Delete(int id)
        {
            using DataContext context = new();
            var uid = context.Shippers.Single(x => x.Id == id);
            context.Entry(uid).State = EntityState.Deleted;
            context.SaveChanges();
        }

        public List<Shipper> GetAll()
        {
            using DataContext context = new();
            return [.. context.Shippers];
        }

        public List<Shipper> GetByCity(string city)
        {
            using DataContext context = new();
            return [.. context.Shippers.Where(x => x.City == city)];
        }

        public List<Shipper> GetByCountry(string country)
        {
            using DataContext context = new();
            return [.. context.Shippers.Where(x => x.Country == country)];
        }

        public List<Shipper> GetByDate(DateTime date)
        {
            using DataContext context = new();
            return [.. context.Shippers.Where(x => x.Date_ == date)];
        }

        public Shipper GetById(int id)
        {
            using DataContext context = new();
            return context.Shippers.Single(y => y.Id == id);
        }

        public Shipper GetByName(string name)
        {
            using DataContext context = new();
            return context.Shippers.Single(x => x.Name == name);
        }

        public Shipper GetByNumber(string number)
        {
            using DataContext context = new();
            return context.Shippers.Single(x => x.Number == number);
        }

        public List<Shipper> GetByPostalCode(string postalCode)
        {
            using DataContext context = new();
            return [.. context.Shippers.Where(x => x.PostalCode == postalCode)];
        }

        public List<Shipper> GetByRegion(string region)
        {
            using DataContext context = new();
            return [.. context.Shippers.Where(x => x.Region == region)];
        }

        public void Update(Shipper entity, int id)
        {
            using DataContext context = new();
            var uid = context.Shippers.Single(x => x.Id == id);
            uid.Number = entity.Number;
            uid.Name = entity.Name;
            uid.PostalCode = entity.PostalCode;
            uid.Address = entity.Address;
            uid.City = entity.City;
            uid.ContactName = entity.ContactName;
            uid.Country = entity.Country;
            uid.Region = entity.Region;
            uid.Date_ = entity.Date_;
            context.Entry(uid).State = EntityState.Modified;
            context.SaveChanges();
        }
    }
}
