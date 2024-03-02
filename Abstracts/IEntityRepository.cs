using Entities.Abstracts;
using System.Linq.Expressions;

namespace DataAccess.Abstracts;

public interface IEntityRepository<TEntity> where TEntity : class, IEntity, new()
{
    List<TEntity> GetAll(Expression<Func<TEntity, bool>> filter = null);
    void Add(TEntity entity);
    void Update(TEntity entity); 

}
