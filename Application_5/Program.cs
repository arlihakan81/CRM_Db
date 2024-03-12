
using Application_5.Business.Concretes;
using Application_5.DataAccess.Concretes;
using Application_5.Entities.Concretes;

CreditManager creditManager = new(new CreditDal());
List<Credit> creditCustomerIdIs = creditManager.GetByCustomerId(2);
List<Credit> allCredits = creditManager.GetAll();
List<Credit> creditsCreditTypeIs = creditManager.GetByCreditType(CreditType.VehicleLoan);
foreach (Credit item in creditsCreditTypeIs)
{
    Console.WriteLine("Kredi No: {0}",item.Number);
    Console.WriteLine("Kredi Adı: {0}",item.Name);
    Console.WriteLine("Müşteri No: {0}",item.Customer.Number);
    Console.WriteLine("Müşteri Adı Soyadı: {0}", item.Customer.FullName);
    Console.WriteLine("Kredi Tutarı: {0}", item.Limit);
    Console.WriteLine("Geri Ödenecek Tutar: {0}", item.TotalPayback);
    Console.WriteLine("Faiz Oranı: {0}", item.RateOfInterest);
    Console.WriteLine("Kredi Tarihi: {0}",item.Date_);
    Console.WriteLine("***********************************************");
}










Console.ReadLine();
