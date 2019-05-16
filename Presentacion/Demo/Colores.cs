using Microsoft.SolverFoundation.Services;
using System;

namespace Demo
{
    public class Colores
    {
        public static void Run()
        {
            SolverContext context = SolverContext.GetContext();
            Model model = context.CreateModel();

            //Define the domain
            Domain colors = Domain.Enum("red", "green", "blue", "yellow");

            //Create the decision variable
            Decision be = new Decision(colors, "belgium");
            Decision de = new Decision(colors, "germany");
            Decision fr = new Decision(colors, "france");
            Decision nl = new Decision(colors, "netherlands");

            // Add decision variables to the model
            model.AddDecisions(be, de, fr, nl);
            // Add constraint to the model
            model.AddConstraints("borders", be != de, be != fr, be != nl, de != fr, de != nl);

            Solution solution = context.Solve(new ConstraintProgrammingDirective());
            int numSoluciones = 0;

            Console.WriteLine("Muestra todas las combinaciones de colores para pintar en el mapa 4 paises con 4 colores sin que dos paises que comparten frontera tengan el mismo color.");
            while (solution.Quality != SolverQuality.Infeasible)
            {
                Console.WriteLine(string.Format("{4}-> Belgium: {0}\tGermany: {1}\tFrance: {2}\tNetherlands: {3}", be, de, fr, nl, ++numSoluciones));
                solution.GetNext();
            }
            Console.WriteLine(string.Format(numSoluciones > 1 ? "Encontradas {0} soluciones." : "Encontrada {0} solucion.", numSoluciones));

        }
    }
}