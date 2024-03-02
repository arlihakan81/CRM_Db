using DataAccess.Abstracts;
using Entities.Concretes;
using System.Linq.Expressions;

namespace Business.Concretes;

public class EmployeeManager
{
    private readonly IEmployeeDal _empDal;

    public EmployeeManager(IEmployeeDal empDal)
    {
        _empDal = empDal;
    }

    public List<Employee> GetAll(Expression<Func<Employee, bool>> filter=null)
    {
        return _empDal.GetAll(filter);
    }

    public Employee Get(int id)
    {
        return _empDal.Get(id);
    }

    public void Add(Employee emp)
    {
        _empDal.Add(emp);
    }

    public void Update(Employee emp)
    {
        _empDal.Update(emp);
    }

    public void Delete(int id) 
    {
        _empDal.Delete(id);
    }
}
