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
            Decision ge = new Decision(colors, "germany");
            Decision fr = new Decision(colors, "france");
            Decision nl = new Decision(colors, "netherlands");

            // Add decision variables to the model
            model.AddDecisions(be, ge, fr, nl);
            // Add constraint to the model
            model.AddConstraints("borders", be != ge, be != fr, be != nl, ge != fr, ge != nl);

            Solution solution = context.Solve(new ConstraintProgrammingDirective());
            int numSolutions = 0;

            Console.WriteLine("Show all combination for 4 countries with 4 colors whitout repeat colors between two countries sharing border.");
            while (solution.Quality != SolverQuality.Infeasible)
            {
                Console.WriteLine(string.Format("{4}-> Belgium: {0}\tGermany: {1}\tFrance: {2}\tNetherlands: {3}", be, ge, fr, nl, ++numSolutions));
                solution.GetNext();
            }
            Console.WriteLine(string.Format(numSolutions > 1 ? "Find {0} solutions." : "Find {0} solution.", numSolutions));

        }
    }
}