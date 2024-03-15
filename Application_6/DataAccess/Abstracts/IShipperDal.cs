using Entities.Concretes;

namespace DataAccess.Abstracts
{
    public interface IShipperDal:IEntityRepository<Shipper>
    {
        Shipper GetByNumber(string number);
        Shipper GetByName(string name);
        List<Shipper> GetByCity(string city);
        List<Shipper> GetByCountry(string country);
        List<Shipper> GetByRegion(string region);
        List<Shipper> GetByPostalCode(string postalCode);

    }
}
