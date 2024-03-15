using Entities.Concretes;

namespace DataAccess.Abstracts
{
    public interface IEmployeeDal:IEntityRepository<Employee>
    {
        List<Employee> GetByCity(string city);
        List<Employee> GetByCountry(string country);
        List<Employee> GetByDepartmentId(int id);
        List<Employee> GetBySalary(double salary);
        List<Employee> GetByHireDate(DateTime hireDate);
        List<Employee> GetByTitle(string title);

    }
}
