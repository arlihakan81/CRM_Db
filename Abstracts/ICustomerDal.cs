using Entities.Concretes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Abstracts;

public interface ICustomerDal:IEntityRepository<Customer>
{
    Customer Get(string id);
    void Delete(string id);
}
