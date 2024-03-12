using Application_5.Entities.Concretes;

namespace Application_5.DataAccess.Abstracts
{
    public interface IAccountDal:IEntityRepository<Account>
    {
        List<Account> GetByCustomerId(int id);
        List<Account> GetByUsableLimit(double limit);
        List<Account> GetByTotalLimit(double limit);


    }
}
