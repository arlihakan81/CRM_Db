
using Entities.Abstracts;

namespace DataAccess.Abstracts
{
    public interface IEntityRepository<T> where T : class, IEntity, new()
    {
        List<T> GetAll();
        T GetById(int id);
        List<T> GetByDate(DateTime date);
        void Add(T entity);
        void Update(T entity, int id);
        void Delete(int id);
    }
}
