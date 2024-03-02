using DataAccess.Abstracts;
using Entities.Concretes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace Business.Concretes;

public class ProductManager
{
    private readonly IProductDal _productDal;

    public ProductManager(IProductDal productDal)
    {
        _productDal = productDal;
    }

    public List<Product> GetAll(Expression<Func<Product,bool>> filter=null)
    {
        return _productDal.GetAll(filter);
    }

    public Product Get(int id)
    {
        return _productDal.Get(id);
    }

    public void Add(Product product)
    {
        _productDal.Add(product);
    }

    public void Update(Product product)
    {
        _productDal.Update(product);
    }

    public void Delete(int id)
    {
        _productDal.Delete(id);
    }

}
