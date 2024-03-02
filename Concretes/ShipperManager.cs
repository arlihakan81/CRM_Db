using DataAccess.Abstracts;
using Entities.Concretes;
using System.Linq.Expressions;

namespace Business.Concretes;

public class ShipperManager
{
    private readonly IShipperDal _shipperDal;

    public ShipperManager(IShipperDal shipperDal)
    {
        _shipperDal = shipperDal;
    }

    public List<Shipper> GetAll(Expression<Func<Shipper, bool>> filter = null)
    {
        return _shipperDal.GetAll();
    }

    public Shipper Get(int id)
    {
        return _shipperDal.Get(id);
    }

    public void Add(Shipper shipper)
    {
        _shipperDal.Add(shipper);
    }

    public void Delete(int id)
    {
        _shipperDal.Delete(id);
    }

    public void Update(Shipper shipper)
    {
        _shipperDal.Update(shipper);
    }
}
