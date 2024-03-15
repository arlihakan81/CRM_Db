using Microsoft.EntityFrameworkCore;
using DataAccess.Abstracts;
using Entities.Concretes;

namespace DataAccess.Concretes
{
    public class CategoryDal : ICategoryDal
    {
        public void Add(Category entity)
        {
            using DataContext context = new();
            context.Entry(entity).State = EntityState.Added;
            context.SaveChanges();
        }

        public void Delete(int id)
        {
            using DataContext context = new();
            var uid = context.Categories.Single(x => x.Id == id);
            context.Entry(uid).State = EntityState.Deleted;
            context.SaveChanges();
        }

        public List<Category> GetAll()
        {
            using DataContext context = new();
            return [.. context.Categories];
        }

        public List<Category> GetByDate(DateTime date)
        {
            using DataContext context = new();
            return [.. context.Categories.Where(x => x.Date_ == date)];
        }
            
        public Category GetById(int id)
        {
            using DataContext context = new();
            return context.Categories.Single(x => x.Id == id);
        }

        public Category GetByName(string name)
        {
            using DataContext context = new();
            return context.Categories.Single(x => x.Name == name);
        }

        public void Update(Category entity, int id)
        {
            using DataContext context = new();
            var uid = context.Categories.Single(x => x.Id == id);
            uid.Name = entity.Name;
            uid.Description = entity.Description;
            uid.Date_ = entity.Date_;
            context.Entry(uid).State= EntityState.Modified;
            context.SaveChanges();
        }
    }
}
