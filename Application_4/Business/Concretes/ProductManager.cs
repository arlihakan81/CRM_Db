using Application_4.DataAccess.Abstracts;
using Application_4.Entities.Concretes;

namespace Application_4.Business.Concretes
{
    public class ProductManager
    {
        private IProductDal _productDal;
        public ProductManager(IProductDal productDal) 
        {
            _productDal = productDal;
        }

        public void Add(Product entity)
        {
            _productDal.Add(entity);
        }

        public void ApplyTax(double rate)
        {
            _productDal.ApplyTax(rate);
        }

        public void Delete(int id)
        {
            _productDal.Delete(id);
        }

        public List<Product> GetAll()
        {
            return _productDal.GetAll();
        }

        public List<Product> GetByCategoryId(int id)
        {
            return _productDal.GetByCategoryId(id);
        }

        public Product GetById(int id)
        {
            return _productDal.GetById(id);
        }

        public List<Product> GetByPrice(double price)
        {
            return _productDal.GetByPrice(price);
        }

        public List<Product> GetByQuantity(int quantity)
        {
            return _productDal.GetByQuantity(quantity);
        }

        public int GetCount()
        {
            return _productDal.GetCount();
        }

    }
}
