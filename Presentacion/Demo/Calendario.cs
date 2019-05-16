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
            CspDomain gamesInterval = S.CreateIntegerInterval(0, N - 1);
            CspTerm[][] games = S.CreateVariableArray(gamesInterval, "Foe", N, N - 1);

            for (int t = 0; t < N; t++)
            {
                S.AddConstraints(                   // Agregamos las constraints
                  S.Unequal(t, games[t]),        // Un equipo no puede jugar consigo mismo
                  S.Equal(t ^ 1, games[t][0])    // la primera ronda se emparejan pares con impares
                );
            }

            for (int w = 0; w < N - 1; w++)
            {
                S.AddConstraints(S.Unequal(GetColumn(games, w))); // cada equipo solo juega una vez cada jornada
            }

            ShowSolution(N, S, games);
        }

        private static void ShowSolution(int N, ConstraintSystem S, CspTerm[][] games)
        {
            bool unsolved = true;
            ConstraintSolverSolution soln = S.Solve();
            if (soln.HasFoundSolution)
            {
                unsolved = false;

                System.Console.WriteLine(String.Format("Calendar for {0} teams.", N));

                StringBuilder line = new StringBuilder("Team  ");
                for (int i = 0; i < N; i++)
                    line.Append("J" + (i + 1).ToString() + " ");

                System.Console.WriteLine(line.ToString());

                for (int t = 0; t < N; t++)
                {
                    line = new StringBuilder("   ");
                    line.Append(t.ToString());
                    line.Append(": ");
                    for (int w = 0; w < N - 1; w++)
                    {
                        if (!soln.TryGetValue(games[t][w], out object opponent))
                            throw new InvalidProgramException(games[t][w].Key.ToString());
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