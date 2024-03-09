
using Application_1.Business.Concretes;
using Application_1.DataAccess.Concretes;
using Application_1.Entities.Concretes;


ProductManager productManager = new(new ProductDal());
//productManager.Add(new Product { Id = 11, Name = "akdmadkms" });
//productManager.Delete(5);
//productManager.GetById(1);
List<Product> products = productManager.GetAllByCategoryId(2);
foreach (Product product in products)
{
    Console.WriteLine(product.Id + "." + product.Name);
}

//CustomerManager customerManager = new(new CustomerDal());
//List<Customer> customers = customerManager.GetAll();
//foreach (Customer customer in customers)
//{
//    Console.WriteLine(customer.Id+"."+customer.FirstName);
//}

//OrderManager orderManager = new(new OrderDal());
////List<Order> orders =  orderManager.GetOrdersByOrderState(OrderState.Cancelled);
////List<Order> orders =  orderManager.GetOrdersByOrderDate(DateTime.Parse("11.02.2024"));
//List<Order> orders =  orderManager.GetOrdersByProductId(2);
//foreach (Order order in orders)
//{
//    Console.WriteLine(order.Id);
//}




//CategoryManager categoryManager = new(new CategoryDal());
//List<Category> categories = categoryManager.GetAll();
//foreach (Category category in categories)
//{
//    Console.WriteLine(category.Id+"."+category.Name);
//}

Console.ReadLine();
