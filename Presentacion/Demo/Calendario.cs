using Microsoft.SolverFoundation.Solvers;
using System;
using System.Text;

namespace Demo
{
    public class Calendario
    {
        public static void Run(int N)
        {
            ConstraintSystem S = ConstraintSystem.CreateSolver();
            CspDomain Equipos = S.CreateIntegerInterval(0, N - 1);
            CspTerm[][] partidos = S.CreateVariableArray(Equipos, "Oponentes", N, N - 1);

            for (int t = 0; t < N; t++)
            {
                S.AddConstraints(                   // Agregamos las constraints
                  S.Unequal(t, partidos[t]),        // Un equipo no puede jugar consigo mismo
                  S.Equal(t ^ 1, partidos[t][0])    // la primera ronda se emparejan pares con impares
                );
            }

            for (int w = 0; w < N - 1; w++)
            {
                S.AddConstraints(S.Unequal(GetColumn(partidos, w))); // cada equipo solo juega una vez cada jornada
            }

            MostrarSolucion(N, S, partidos);
        }

        private static void MostrarSolucion(int N, ConstraintSystem S, CspTerm[][] partidos)
        {
            bool unsolved = true;
            ConstraintSolverSolution soln = S.Solve();
            if (soln.HasFoundSolution)
            {
                unsolved = false;

                System.Console.WriteLine(String.Format("Calendario de partidos para {0} equipos.", N));

                StringBuilder linea = new StringBuilder("Equipo  ");
                for (int i = 0; i < N; i++)
                    linea.Append("J" + (i + 1).ToString() + " ");

                System.Console.WriteLine(linea.ToString());

                for (int t = 0; t < N; t++)
                {
                    StringBuilder line = new StringBuilder("     ");
                    line.Append(t.ToString());
                    line.Append(": ");
                    for (int w = 0; w < N - 1; w++)
                    {
                        if (!soln.TryGetValue(partidos[t][w], out object opponent))
                            throw new InvalidProgramException(partidos[t][w].Key.ToString());
                        line.Append(opponent.ToString());
                        line.Append("  ");
                    }
                    System.Console.WriteLine(line.ToString());
                }
                System.Console.WriteLine();
            }
            if (unsolved)
                System.Console.WriteLine("No solution found.");
        }

        static private CspTerm[] GetColumn(CspTerm[][] termArray, int column)
        {
            int N = termArray.Length;
            if (N < 1)
                return null;
            CspTerm[] slice = new CspTerm[N];
            for (int row = 0; row < N; row++)
                slice[row] = termArray[row][column];
            return slice;
        }
    }
}