using DataAccess.Abstracts;
using Entities.Concretes;

namespace DataAccess.Concretes
{
    public class DepartmentDal : IDepartmentDal
    {
        public void Add(Department entity)
        {
            using DataContext context = new();
            context.Entry(entity).State = Microsoft.EntityFrameworkCore.EntityState.Added;
            context.SaveChanges();
        }

        public void Delete(int id)
        {
            using DataContext context = new();
            Department department = context.Departments.Single(x => x.Id == id);
            context.Entry(department).State = Microsoft.EntityFrameworkCore.EntityState.Deleted;
            context.SaveChanges();
        }

        public List<Department> GetAll()
        {
            using DataContext context = new();
            return [.. context.Departments];
        }

        public List<Department> GetByDate(DateTime date)
        {
            using DataContext context = new();
            return [.. context.Departments.Where(x => x.Date_ == date)];
        }

        public Department GetById(int id)
        {
            using DataContext context = new();
            return context.Departments.SingleOrDefault(x=> x.Id == id);
        }

        public Department GetByName(string name)
        {
            using DataContext context = new();
            return context.Departments.Where(x => x.Name == name).SingleOrDefault();
        }

        public void Update(Department entity, int id)
        {
            using DataContext context = new();
            var uid = context.Departments.Single(x => x.Id == id);
            uid.Name = entity.Name;
            uid.Description = entity.Description;
            uid.Date_ = entity.Date_;
            context.Entry(uid).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
            context.SaveChanges();
        }
    }
}
