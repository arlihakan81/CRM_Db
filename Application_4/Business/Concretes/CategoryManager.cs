using Application_4.DataAccess.Abstracts;
using Application_4.Entities.Concretes;

namespace Application_4.Business.Concretes
{
    public class CategoryManager
    {
        private ICategoryDal _categoryDal;
        public CategoryManager(ICategoryDal categoryDal) 
        {
            _categoryDal = categoryDal;
        }
        public void Add(Category entity)
        {
            _categoryDal.Add(entity);
        }

        public void Delete(int id)
        {
            _categoryDal.Delete(id);
        }

        public List<Category> GetAll()
        {
            return _categoryDal.GetAll();
        }

        public Category GetById(int id)
        {
            return _categoryDal.GetById(id);
        }
    }
}
