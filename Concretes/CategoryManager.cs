using DataAccess.Abstracts;
using Entities.Concretes;
using System.Linq.Expressions;

namespace Business.Concretes;

public class CategoryManager
{
    private readonly ICategoryDal _categoryDal;

    public CategoryManager(ICategoryDal categoryDal)
    {
        _categoryDal = categoryDal;
    }

    public List<Category> GetAll(Expression<Func<Category, bool>> filter=null)
    {
        return _categoryDal.GetAll(filter);
    }

    public void Add(Category category)
    {
        _categoryDal.Add(category);
    }

    public void Update(Category category)
    {
        _categoryDal.Update(category);
    }

    public void Delete(int id) 
    {
        _categoryDal.Delete(id);
    }
}
