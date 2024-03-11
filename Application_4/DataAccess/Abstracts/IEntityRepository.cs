using Application_4.Entities.Abstracts;

namespace Application_4.DataAccess.Abstracts
{
    public interface IEntityRepository<T> where T : class, IEntity, new()
    {
        List<T> GetAll();
        T GetById(int id);
        void Add(T entity);
        void Delete(int id);

    }
}
