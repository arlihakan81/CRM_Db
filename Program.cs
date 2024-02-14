using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Otopark_Otomasyonu
{
    internal class Program
    {
        static void Main(string[] args)
        {
            /*
              Bir otoparkta ticari aracın saatlik ücreti 15 TL, Otobüsün saatlik ücreti 25 TL,
            Minibüsün saatlik ücreti 20, Kamyonetin saatlik 30 TL, Binek aracın saatlik ücreti 10 TL
            şeklinde ücretlendirme vardır. 
                Ticari aracın 1 saat aşımında her saat başına %12 artış,
                Minibüsün 1 saat sonrasında her saat başına %15 artış,
                Otobüsün 1 saat sonrasında her saat başına %18 artış,
                Kamyonetin 1 saat sonrasında her saat başına %20 artış,
                Binek aracın 1 saat sonrasında her saat başına %10 artış yapılacaktır.
            Buna göre, kullanıcıdan araç tipi ve park süresi girilmesi istenecektir. Ödenecek tutar belirlenip
            ekrana yazdırılacaktır.
            */

            try
            {
                double ticariArac = 15, otobus = 25, minibus = 20, binekArac = 10, kamyonet = 30;
                double odenecekTutar = 0;
                BasaDon:
                Console.WriteLine("********Otoparka Hoşgeldiniz**********");
                Thread.Sleep(3000);
                Console.WriteLine("Binek araç için -->  1");
                Console.WriteLine("Otobüs için --> 2");
                Console.WriteLine("Ticari araç için --> 3");
                Console.WriteLine("Minibüs için --> 4");
                Console.WriteLine("Kamyonet için --> 5");
                Console.WriteLine("Lütfen bir araç tipi seçin");
                int secim = int.Parse(Console.ReadLine());
                if(secim > 0 && secim < 6)
                {
                    if(secim == 1)
                    {
                        Thread.Sleep(1000);
                        Console.WriteLine("Lütfen aracınızın park süresini girin");
                        int parkSuresi = int.Parse(Console.ReadLine());
                        if(parkSuresi > 1)
                        {
                            for(int i = 1; i <= parkSuresi; i++)
                            {
                                odenecekTutar += binekArac + binekArac * 0.1;
                            }
                        }
                        else if(parkSuresi <= 1)
                        {
                            odenecekTutar += binekArac;
                        }
                    }
                    else if (secim == 2)
                    {
                        Thread.Sleep(1000);
                        Console.WriteLine("Lütfen aracınızın park süresini girin");
                        int parkSuresi = int.Parse(Console.ReadLine());
                        if (parkSuresi > 1)
                        {
                            for (int i = 1; i <= parkSuresi; i++)
                            {
                                odenecekTutar += otobus + otobus * 0.18;
                            }
                        }
                        else if (parkSuresi <= 1)
                        {
                            odenecekTutar += otobus;
                        }
                    }
                    else if (secim == 3)
                    {
                        Thread.Sleep(1000);
                        Console.WriteLine("Lütfen aracınızın park süresini girin");
                        int parkSuresi = int.Parse(Console.ReadLine());
                        if (parkSuresi > 1)
                        {
                            for (int i = 1; i <= parkSuresi; i++)
                            {
                                odenecekTutar += ticariArac + ticariArac * 0.12;
                            }
                        }
                        else if (parkSuresi <= 1)
                        {
                            odenecekTutar += ticariArac;
                        }
                    }
                    else if (secim == 4)
                    {
                        Thread.Sleep(1000);
                        Console.WriteLine("Lütfen aracınızın park süresini girin");
                        int parkSuresi = int.Parse(Console.ReadLine());
                        if (parkSuresi > 1)
                        {
                            for (int i = 1; i <= parkSuresi; i++)
                            {
                                odenecekTutar += minibus + minibus * 0.18;
                            }
                        }
                        else if (parkSuresi <= 1)
                        {
                            odenecekTutar += minibus;
                        }
                    }
                    else if (secim == 5)
                    {
                        Thread.Sleep(1000);
                        Console.WriteLine("Lütfen aracınızın park süresini girin");
                        int parkSuresi = int.Parse(Console.ReadLine());
                        if (parkSuresi > 1)
                        {
                            for (int i = 1; i <= parkSuresi; i++)
                            {
                                odenecekTutar += kamyonet + kamyonet * 0.2;
                            }
                        }
                        else if (parkSuresi <= 1)
                        {
                            odenecekTutar += kamyonet;
                        }
                    }

                    Console.WriteLine("Ödenecek tutar hesaplanıyor....");
                    Thread.Sleep(2000);
                    Console.WriteLine($"Ödenecek tutarınız: {odenecekTutar}");
                }
                else
                {
                    Console.WriteLine("Lütfen geçerli bir araç tipi seçin");
                    goto BasaDon;
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }

            Console.ReadLine();
        }
    }
}
