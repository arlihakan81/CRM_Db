using Application_5.Entities.Abstracts;
using System.Linq.Expressions;

namespace Application_5.DataAccess.Abstracts
{
    public interface IEntityRepository<T> where T : class, IEntity, new()
    {
        List<T> GetAll(Expression<Func<T,bool>> filter=null);
        T GetById(int id);
        List<T> GetByName(string name);
        List<T> GetByDate(DateTime date);
        void Add(T entity);
        void Update(T entity, int id);
        void Delete(int id);

    }
}
