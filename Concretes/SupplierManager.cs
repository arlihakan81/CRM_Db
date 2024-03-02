using DataAccess.Abstracts;
using Entities.Concretes;
using System.Linq.Expressions;

namespace Business.Concretes;

public class SupplierManager
{
    private readonly ISupplierDal _supplierDal;

    public SupplierManager(ISupplierDal supplierDal)
    {
        _supplierDal = supplierDal;
    }

    public List<Supplier> GetAll(Expression<Func<Supplier, bool>> filter=null)
    {
        return _supplierDal.GetAll(filter);
    }

    public Supplier Get(int id)
    {
        return _supplierDal.Get(id);
    }

    public void Add(Supplier supplier)
    {
        _supplierDal.Add(supplier);
    }

    public void Update(Supplier supplier)
    {
        _supplierDal.Update(supplier);
    }

    public void Delete(int id) 
    {
        _supplierDal.Delete(id);
    }
}
