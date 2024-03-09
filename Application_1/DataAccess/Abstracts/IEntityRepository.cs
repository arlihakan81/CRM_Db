using Application_1.Entities.Abstracts;
using System.Linq.Expressions;

namespace Application_1.DataAccess.Abstracts
{
    public interface IEntityRepository<TEntity> where TEntity : class, IEntity, new()
    {
        List<TEntity> GetAll();
        TEntity GetById(int id);
        void Add(TEntity entity);
        void Update(TEntity entity);
        void Delete(int id);
    }
}
