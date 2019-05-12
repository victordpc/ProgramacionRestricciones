using System;
using System.Text;

namespace Demo
{
    class Program
    {
        static void Main(string[] args)
        {
            Reinas.Run(8);
            Console.WriteLine("Pulse Enter para el siguiente ejemplo.");
            Console.ReadLine();

            Calendario.Run(8);
            Console.WriteLine("Pulse Enter para el siguiente ejemplo.");
            Console.ReadLine();

            Colores.Run();
            Console.WriteLine("Pulse Enter para finalizar.");
            Console.ReadLine();
        }
    }
}
