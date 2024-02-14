using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Hesap_Makinesi_Konsol
{
    internal class Program
    {
        static void Main(string[] args)
        {
            List<decimal> sayilar = new List<decimal>();



            try
            {
                Console.WriteLine("****Hesap Makinesi****");
                Thread.Sleep(1000);
                Console.WriteLine("1 --> Toplama");
                Console.WriteLine("2 --> Çıkarma");
                Console.WriteLine("3 --> Çarpma");
                Console.WriteLine("4 --> Bölme");
                Console.WriteLine("5 --> Üs Alma");
                Console.WriteLine("6 --> Faktöriyel");
                IslemSec:
                Console.WriteLine("Lütfen yukarıdaki işlemlerden birini seçiniz");
                int islem = int.Parse(Console.ReadLine());
                if(islem > 0 && islem < 7)
                {
                    if(islem == 1)
                    {
                        Console.WriteLine("Toplama işlemi siz 0 girene kadar girdiğiniz tüm sayıları toplar.");
                        Thread.Sleep(2000);
                        decimal i = 0;
                        do
                        {
                            Console.WriteLine("Lütfen bir sayı giriniz");
                            decimal sayi = decimal.Parse(Console.ReadLine());
                            sayilar.Add(sayi);
                        } while (sayilar.Contains(i));
                        Topla(sayilar);
                    }
                    else if (islem == 2)
                    {
                        Console.WriteLine("Çıkarma işlemi siz 0 girene kadar girdiğiniz tüm sayıları toplar.");
                        Thread.Sleep(2000);
                        decimal i = 0;
                        do
                        {
                            Console.WriteLine("Lütfen bir sayı giriniz");
                            decimal sayi = decimal.Parse(Console.ReadLine());
                            sayilar.Add(sayi);
                        } while (sayilar.Contains(i));
                        Cikar(sayilar);
                    }
                    else if (islem == 3)
                    {
                        Console.WriteLine("Çarpma işlemi siz 0 girene kadar girdiğiniz tüm sayıları toplar.");
                        Thread.Sleep(2000);
                        decimal i = 0;
                        do
                        {
                            Console.WriteLine("Lütfen bir sayı giriniz");
                            decimal sayi = decimal.Parse(Console.ReadLine());
                            sayilar.Add(sayi);
                        } while (sayilar.Contains(i));
                        Carp(sayilar);
                    }
                    else if (islem == 4)
                    {
                        Console.WriteLine("Lütfen Bölüneni giriniz");
                        int bolunen = int.Parse(Console.ReadLine());
                        Console.WriteLine("Lütfen Böleni giriniz");
                        int bolen = int.Parse(Console.ReadLine());
                        Bol(bolunen, bolen);
                    }
                }
                else
                {
                    Console.WriteLine("Lütfen işleminiz 1-6 arasında olsun");
                    goto IslemSec;
                }

            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }


            Console.ReadLine();

        }

        static void Topla(List<decimal> sayilar)
        {
            decimal toplam = 0;
            foreach(var sayi in sayilar)
            {
                toplam += sayi;
                Console.WriteLine($"{toplam}");
            }
        }

        static void Cikar(List<decimal> sayilar)
        {
            decimal fark = 0;
            foreach (var sayi in sayilar)
            {
                fark -= sayi;
                Console.WriteLine($"{fark}");
            }
        }

        static void Carp(List<decimal> sayilar)
        {
            decimal carpim = 1;
            foreach (var sayi in sayilar)
            {
                carpim *= sayi;
                Console.WriteLine($"{carpim}");
            }
        }

        static void Bol(int sayi1, int sayi2)
        {
            if(sayi2 != 0)
            {
                decimal bolum = 0;
                bolum = sayi1 / sayi2;
                Console.WriteLine($"{bolum}");
            }
            else
            {
                Console.WriteLine("Sıfıra bölme hatası");
            }
        }
    }
}
