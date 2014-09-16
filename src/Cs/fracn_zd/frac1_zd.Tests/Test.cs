using NUnit.Framework;
using System;
using frac1_zd;

namespace frac1_zd.Tests
{
    [TestFixture()]
    public class Test
    {
        [TestCase(1, 1, Result=1)]
        [TestCase(4, 6, Result=2)]
        [TestCase(20, 16, Result=4)]
        [TestCase(-20, 16, Result=4)]
        [TestCase(20, -16, Result=4)]
        public int GCDTest(int m, int n)
        {
            return Frac.GCD(m, n);
        }

        [Test()]
        [TestCase("a a")]
        [TestCase("a 1")]
        [TestCase("1 a")]
        public void RejectLettersOnInput(string str)
        {
//            foreach (string str in new string[] { "a a", "1 a", "a 1" }) {
//                Assert.Throws<Exception>(() => MainClass.SetFrac(str));
//            }
            Assert.Throws<Exception>(() => MainClass.SetFrac(str));
        }
        
        [TestCase(1, 2, Result="1/2")]
        [TestCase(-22, 16, Result="-22/16")]
        public string ReprTest(int m, int n)
        {
            return new Frac(m, n).Repr();
        }


        [Test]
        [TestCase(new int[] {2, 6}, new int[] {1, 3})]
        [TestCase(new int[] {-15, 10}, new int[] {-3, 2})]
        public void SimplifyTest(int[] f_data, int[] f_expected)
        {
            Frac f = new Frac(f_data[0], f_data[1]);
            f.Simplify();
            Assert.AreEqual(f.Num, f_expected[0]);
            Assert.AreEqual(f.Denom, f_expected[1]);
        }

        [Test]
        public void DenominatorCannotBeNegative()
        {
            Exception ex = Assert.Throws<Exception>(
                delegate { new Frac(1, -1); }
            );
            Assert.That(ex.Message, Is.EqualTo("Denominator cannot be negative"));
//            Assert.Throws<Exception>(() => new Frac(1, -1));
        }
    }
}

