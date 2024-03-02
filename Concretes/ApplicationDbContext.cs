using Entities.Concretes;
using Microsoft.EntityFrameworkCore;

namespace DataAccess.Concretes;

public class ApplicationDbContext:DbContext
{
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlServer(@"Server=(localdb)\mssqllocaldb; Database=Northwind; Trusted_Connection=true");
    }
    
    public DbSet<Customer> Customers { get; set; }
    public DbSet<Category> Categories { get; set; }
    public DbSet<Product> Products { get; set; }
    public DbSet<Shipper> Shippers { get; set; }
    public DbSet<Supplier> Suppliers { get; set; }
    public DbSet<Employee> Employees { get; set; }
    public DbSet<Order> Orders { get; set; }
    public DbSet<OrderDetail> OrderDetails { get; set; }


}
