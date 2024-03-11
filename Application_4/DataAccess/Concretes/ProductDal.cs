using Application_4.DataAccess.Abstracts;
using Application_4.Entities.Concretes;

namespace Application_4.DataAccess.Concretes
{
    public class ProductDal : IProductDal
    {
        public List<Product> _products = [];
        public ProductDal()
        {
            _products.Add(new Product { Id=1, Name="Bilgisayar", Description="HP Pavilion Notebook", Price=10299, Quantity=100, CategoryId=1 });
            _products.Add(new Product { Id=2, Name="Telefon", Description="Samsung Galaxy A32", Price=8999, Quantity=50, CategoryId=1 });
            _products.Add(new Product { Id=3, Name="Buzdolabı", Description="Arçelik No-Frost A+ Buzdolabı", Price=12399, Quantity=70, CategoryId=2 });
            _products.Add(new Product { Id=4, Name="Deterjan", Description="Desto Bulaşık Deterjanı", Price=50, Quantity=85, CategoryId=4 });
            _products.Add(new Product { Id=5, Name="Çerez", Description="Simbat Sarı Leblebi 250g", Price=59, Quantity=150, CategoryId=5 });
        }
        public void Add(Product entity)
        {
            _products.Add(entity);
        }

        public void ApplyTax(double rate)
        {
            foreach(Product product in _products) 
            {
                product.Price = product.Price * rate;
            }
        }

        public void Delete(int id)
        {
            Product product = _products[id];
            _products.Remove(product);
        }

        public List<Product> GetAll()
        {
            return _products;
        }

        public List<Product> GetByCategoryId(int id)
        {
            return [.. _products.Where(x => x.CategoryId == id)];
        }

        public Product GetById(int id)
        {
            return _products[id];
        }

        public List<Product> GetByPrice(double price)
        {
            return [.. _products.Where(x => x.Price == price)];
        }

        public List<Product> GetByQuantity(int quantity)
        {
            return [.. _products.Where(x => x.Quantity == quantity)];
        }

        public int GetCount()
        {
            return _products.Count;
        }

        
    }
}
