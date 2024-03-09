using Application_1.DataAccess.Abstracts;
using Application_1.Entities.Concretes;

namespace Application_1.Business.Concretes
{
    public class ProductManager
    {
        private readonly IProductDal _productDal;
        public ProductManager(IProductDal productDal) 
        {
            _productDal = productDal;    
        }
        public List<Product> GetAll()
        {
            return _productDal.GetAll();
        }

        public List<Product> GetAllByCategoryId(int id)
        {
            return _productDal.GetAllByCategoryId(id);
        }

        public Product GetById(int id)
        {
            return _productDal.GetById(id);
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
}
