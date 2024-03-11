
using Application_4.Business.Concretes;
using Application_4.DataAccess.Concretes;
using Application_4.Entities.Concretes;

Console.WriteLine("Tüm Kategoriler:");
CategoryManager categoryManager = new(new CategoryDal());
List<Category> categories = categoryManager.GetAll();
foreach (Category category in categories)
{
    Console.WriteLine(category.Name);
}
Console.WriteLine("***********************************");

Console.WriteLine("Tüm Ürünler:");
ProductManager productManager = new(new ProductDal());
productManager.ApplyTax(1.2);
List<Product> products = productManager.GetAll();
foreach (Product item in products)
{
    Console.WriteLine(item.Price);
}
Console.WriteLine(productManager.GetCount());
Console.WriteLine("***********************");

Console.WriteLine("Müşteri Ekleme");
CustomerManager customerManager = new(new CustomerDal());
customerManager.Add(
    new Customer
    {
        Id = 7,
        FirstName = "Kemal",
        LastName = "Saymaz",
        Address = "Istanbul",
        Date_ = DateTime.Parse("03.03.2017")
    });
Console.WriteLine("****************************");

Console.WriteLine("Şu tarihte kayıt olan müşteriler: 01.01.2019");
List<Customer> customerList = customerManager.GetByDate(DateTime.Parse("01.01.2019"));
foreach (Customer item in customerList)
{
    Console.WriteLine(item.FirstName+" "+item.LastName);
}
Console.WriteLine("*****************************************************");

Console.WriteLine("Tamamlanan Siparişlerin tarihleri");
OrderManager orderManager =  new(new OrderDal());
List<Order> completedOrders = orderManager.GetByState(OrderState.Completed);
foreach (Order order in completedOrders)
{
    Console.WriteLine(order.Date_);
}

List<Order> paidCashOrders = orderManager.GetByPaymentType(PaymentType.Cash);
foreach(Order order in paidCashOrders)
{
    Console.WriteLine(order.Quantity);
}

List<Order> allOrders = orderManager.GetAll();
foreach (Order order in allOrders)
{
    Console.WriteLine(order.Id);
}


foreach (Product item in products)
{
    Console.WriteLine(item.Id);
    orderManager.CalculateOrderPrice(item.Price);
    Console.WriteLine("************************************************");
}

Console.WriteLine("Siparişlerin Toplam Tutarı: {0} ", orderManager.GetTotalPrice());

Console.ReadLine();