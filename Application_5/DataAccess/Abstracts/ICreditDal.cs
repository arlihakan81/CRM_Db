using Application_5.Entities.Concretes;

namespace Application_5.DataAccess.Abstracts
{
    public interface ICreditDal:IEntityRepository<Credit>
    {
        List<Credit> GetByCreditType(CreditType type);
        List<Credit> GetByLimit(double limit);
        List<Credit> GetByCustomerId(int id);
    }
}
