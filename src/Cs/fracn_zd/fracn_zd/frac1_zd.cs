// "frac1_zd.cs		Зотиков Д.Ю. сентябрь 2014
// 
// Сокращение обыкновенной дрови вида m/n, где
// m - целое, n - целое без знака.
// Проверяется корректность введенных значений.


using System;

namespace fracn_zd
{
	class Frac
	{
		public int m, n;

		public Frac(int m_, int n_)
		{
			m = m_;
			n = n_;
		}

		public static int GCD(int m, int n)
		{
			if (n == 0)
				return m;
			else
				return GCD(n, m % n);
		}

		public void Simplify()
		{
			int gcd = GCD(m, n);
			m /= gcd;
			n /= gcd;
		}

		public string Repr()
		{
			return String.Format("{0}/{1}", m, n);
		}
	}


	class MainClass
	{
		public const string annotation = @"frac1_zd.cs		Зотиков Д.Ю. сентябрь 2014

Сокращение обыкновенной дрови вида m/n, где
m - целое, n - целое без знака.
Проверяется корректность введенных значений.
";

		public static Frac GetFrac()
		{
			Console.Write("Введите через пробел m n (0 0 -- конец): ");
			try {
				string[] input = Console.ReadLine().Split();	// begs for a Convert lambda mapping...
				return new Frac(Convert.ToInt32(input[0]), Convert.ToInt32(input[1]));
			} catch {
				Console.WriteLine("Ошибка ввода.");
				return GetFrac();
			}

		}

		public static void PutFrac(Frac f)
		{
			string OldVal = f.Repr();
			f.Simplify();
			Console.WriteLine("  " + OldVal + " = " + f.Repr());
		}

		public static void Main(string[] args)
		{
			Console.WriteLine(annotation);

			Frac f;
			f = GetFrac();
			while (f.m != 0 || f.n != 0) {
				PutFrac(f);
				f = GetFrac();
			}
			Console.WriteLine("Выполнение закончено");
		}
	}
}