using Application_5.Entities.Concretes;
using Microsoft.EntityFrameworkCore;

namespace Application_5.DataAccess.Concretes
{
    public class DataContext:DbContext
    {

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(@"Server=(localdb)\mssqllocaldb; Database=BankDb; Trusted_Connection=true");
        }

        public DbSet<Account> Accounts { get; set; }
        public DbSet<Customer> Customers { get; set; }
        public DbSet<Credit> Credits { get; set; }
    }
}
