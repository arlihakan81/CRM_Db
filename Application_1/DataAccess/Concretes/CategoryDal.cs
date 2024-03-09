using Application_1.DataAccess.Abstracts;
using Application_1.Entities.Concretes;

namespace Application_1.DataAccess.Concretes
{
    public class CategoryDal : ICategoryDal
    {
        public List<Category> _categories = [];

        public CategoryDal()
        {
            _categories.Add(new Category { Id = 1, Name = "Elektronik" });
            _categories.Add(new Category { Id = 2, Name = "Kişisel Bakım" });
            _categories.Add(new Category { Id = 3, Name = "Temizlik" });
            _categories.Add(new Category { Id = 4, Name = "Aksesuar" });
            _categories.Add(new Category { Id = 5, Name = "Elektrikli Ev Aletleri" });
            _categories.Add(new Category { Id = 6, Name = "Beyaz Eşya" });
        }

        public void Add(Category entity)
        {
            _categories.Add(entity);
        }

        public void Delete(int id)
        {
            var item = _categories.Find(x => x.Id == id);
            _categories.Remove(item);
        }

        public List<Category> GetAll()
        {
            return _categories;
        }

        public Category GetById(int id)
        {
            return _categories.Where(x => x.Id == id).SingleOrDefault();
        }

        public void Update(Category entity)
        {
            throw new NotImplementedException();
        }
    }
}
