using Application_4.DataAccess.Abstracts;
using Application_4.Entities.Concretes;

namespace Application_4.DataAccess.Concretes
{
    public class CategoryDal : ICategoryDal
    {
        public List<Category> _categories = [];
        public CategoryDal()
        {
            _categories.Add(new Category { Id = 1, Name = "Elektronik" });
            _categories.Add(new Category { Id = 2, Name = "Beyaz Eşya" });
            _categories.Add(new Category { Id = 3, Name = "Kişisel Bakım" });
            _categories.Add(new Category { Id = 4, Name = "Temizlik" });
            _categories.Add(new Category { Id = 5, Name = "Yiyecek" });
            _categories.Add(new Category { Id = 6, Name = "İçecek" });
            _categories.Add(new Category { Id = 7, Name = "Giyim" });
            _categories.Add(new Category { Id = 8, Name = "Elektrikli Ev Aletleri" });

        }
        public void Add(Category entity)
        {
            _categories.Add(entity);
        }

        public void Delete(int id)
        {
            Category category = _categories[id];
            _categories.Remove(category);
        }

        public List<Category> GetAll()
        {
            return _categories;
        }

        public Category GetById(int id)
        {
            return _categories[id];
        }
    }
}
