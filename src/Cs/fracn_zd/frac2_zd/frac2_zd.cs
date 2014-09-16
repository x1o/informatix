// "frac2_zd.cs        Зотиков Д.Ю. сентябрь 2014
// 
// Сокращение обыкновенной дрови вида m/n, где
// m - целое, n - целое без знака.
// Проверяется корректность введенных значений.


using System;
using System.IO;

namespace frac2_zd
{
    public class Frac
    {
        public int Num, Denom;

        public Frac(int Num_, int Denom_)
        {
            if (Denom_ < 0) {
                throw new Exception("Denominator cannot be negative");
            }
            Num = Num_;
            Denom = Denom_;
        }

        public static int GCD(int m, int n)
        {
            if (n == 0)
                return Math.Abs(m);
            else
                return GCD(n, m % n);
        }

        public Frac Simplify()
        {
            int gcd = GCD(Num, Denom);
            Num /= gcd;
            Denom /= gcd;
            return this;
        }

        public string Repr()
        {
            return String.Format("{0}/{1}", Num, Denom);
        }
    }


    public class MainClass
    {
        public const string annotation = @"frac2_zd.cs        Зотиков Д.Ю. сентябрь 2014

Сокращение обыкновенной дрови вида m/n, где
m - целое, n - целое без знака.
Проверяется корректность введенных значений.
";

        public static Frac GetFrac()
        {
            Console.Write("Введите через пробел m n (0 0 -- конец): ");
            try {
                return SetFrac(Console.ReadLine());
            } catch {
                Console.WriteLine("Ошибка ввода.");
                return GetFrac();
            }

        }

        public static Frac SetFrac(string input_str)
        {
            try {
                string[] F = input_str.Split();
                return new Frac(Convert.ToInt32(F[0]),
                                Convert.ToInt32(F[1]));
            } catch {
                throw new Exception("Invalid input");
            }
        }

        public static void PutFrac(Frac f, StreamWriter OutFile)
        {
            string OutStr = f.Repr() + " = " + f.Simplify().Repr();

            OutFile.WriteLine(OutStr);
            Console.WriteLine("  " + OutStr);
        }

        public static void Main(string[] args)
        {
            Console.WriteLine(annotation);

            StreamWriter OutFile; 
            try {
                OutFile = new StreamWriter("frac2_zd.res");
            } catch(IOException e) {
                Console.WriteLine(String.Format("Ошибка открытия файла: {1}", e));
                return -1;
            }

            Frac f = GetFrac();
            while (f.Num != 0 || f.Denom != 0) {
                PutFrac(f, OutFile);
                f = GetFrac();
            }
            Console.WriteLine("Выполнение закончено");
            OutFile.Close();
        }
    }
}