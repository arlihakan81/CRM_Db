using Application_1.DataAccess.Abstracts;
using Application_1.Entities.Concretes;

namespace Application_1.DataAccess.Concretes
{
    public class ProductDal : IProductDal
    {
        public List<Product> products = [];

        public ProductDal()
        {
            CategoryDal categoryDal = new ();
            products.Add(new Product { Id = 1, Name = "Bilgisayar", Description = "Hp pavilion notebook", Price = 8000, CategoryId=categoryDal._categories.Single(x=>x.Name=="Elektronik").Id });
            products.Add(new Product { Id = 2, Name = "Tablet", Description = "Samsung Galaxy Tab S7", Price = 8000, CategoryId= categoryDal._categories.Single(x => x.Name == "Elektronik").Id });
            products.Add(new Product { Id = 3, Name = "Telefon", Description = "Samsung Galaxy A32", Price = 8000, CategoryId= categoryDal._categories.Single(x => x.Name == "Elektronik").Id });
            products.Add(new Product { Id = 4, Name = "Saç Kurutma Makinesi", Description = "Philips marka Saç Kurutma Makinesi", Price = 8000, CategoryId = categoryDal._categories.Single(x => x.Name == "Kişisel Bakım").Id });
            products.Add(new Product { Id = 5, Name = "Buzdolabı", Description = "Arçelik marka buzdolabı", Price = 8000, CategoryId = categoryDal._categories.Single(x => x.Name == "Beyaz Eşya").Id });
            products.Add(new Product { Id = 6, Name = "Çamaşır Makinesi", Description = "Arçelik marka çamaşır makinesi", Price = 8000, CategoryId = categoryDal._categories.Single(x => x.Name == "Beyaz Eşya").Id });
            products.Add(new Product { Id = 7, Name = "Bulaşık Makinesi", Description = "Arçelik marka bulaşık makinesi", Price = 8000, CategoryId = categoryDal._categories.Single(x => x.Name == "Beyaz Eşya").Id });
            products.Add(new Product { Id = 8, Name = "Elektrikli Süpürge", Description = "Arçelik marka elektrikli süpürge", Price = 8000, CategoryId = categoryDal._categories.Single(x => x.Name == "Elektrikli Ev Aletleri").Id });
            products.Add(new Product { Id = 9, Name = "Traş Makinesi", Description = "Gillette", Price = 8000, CategoryId = categoryDal._categories.Single(x => x.Name == "Kişisel Bakım").Id });
            products.Add(new Product { Id = 10, Name = "Saç Düzleştirici", Description = "Philips", Price = 8000, CategoryId = categoryDal._categories.Single(x => x.Name == "Kişisel Bakım").Id });
        }

        public void Add(Product entity)
        {
            products.Add(entity);
        }

        public void Delete(int id)
        {
            var item = products.Find(x => x.Id == id);
            products.Remove(item);
        }

        public List<Product> GetAll()
        {
            return products;
        }

        public List<Product> GetAllByCategoryId(int id)
        {
            return [.. products.Where(x => x.CategoryId == id)];
        }

        public Product GetById(int id)
        {
            return products.Where(x => x.Id == id).SingleOrDefault();
        }

        public void Update(Product entity)
        {
            throw new NotImplementedException();
        }
    }
}
