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

            Domain colors = Domain.Enum("red", "green", "blue", "yellow");
            Decision be = new Decision(colors, "belgium");
            Decision de = new Decision(colors, "germany");
            Decision fr = new Decision(colors, "france");
            Decision nl = new Decision(colors, "netherlands");
            model.AddDecisions(be, de, fr, nl);

            model.AddConstraints("borders", be != de, be != fr, be != nl, de != fr, de != nl);

            Solution solution = context.Solve(new ConstraintProgrammingDirective());
            while (solution.Quality != SolverQuality.Infeasible)
            {
                Console.WriteLine(string.Format("Belgium: {0}\tGermany: {1}\tFrance: {2}\tNetherlands: {3}", be, de, fr, nl));
                solution.GetNext();
            }

        }
    }
}
