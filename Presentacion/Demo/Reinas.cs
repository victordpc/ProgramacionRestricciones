using Microsoft.SolverFoundation.Solvers;
using System;

namespace Demo
{
    public class Reinas
    {
        public static void Run(int N)
        {
            //Creamos un sistema de constrains
            ConstraintSystem S = ConstraintSystem.CreateSolver();
            //Creamos un dominio, enteros de 0 a Reinas-1
            CspDomain Filas = S.CreateIntegerInterval(0, N - 1);

            //Matriz con una celda para cada fila del tablero
            CspTerm[] tablero = S.CreateVariableVector(Filas, "Board", N);

            for (int i = 0; i < N; i++)
            {
                for (int j = i + 1; j < N; j++)
                {
                    S.AddConstraints(
                        S.Unequal(tablero[i], tablero[j]) // Columna
                        , S.Unequal(tablero[j] + (j - i), tablero[i]) // Diagonal 1
                        , S.Unequal(tablero[j] - (j - i), tablero[i]) // Diagonal 2
                        );
                }
            }

            ShowSolution(N, S, tablero);
        }

        private static void ShowSolution(int N, ConstraintSystem S, CspTerm[] board)
        {
            bool unsolved = true;
            ConstraintSolverSolution soln = S.Solve();
            if (soln.HasFoundSolution)
            {
                Console.WriteLine(string.Format("Resolve the {0} queens problem.", N));
                unsolved = false;

                string line = "┌──";
                for (int i = 1; i < N; i++)
                    line += "┬──";
                line += "┐";

                Console.WriteLine(line);

                for (int i = 0; i < N; i++)
                {
                    line = "";

                    if (!soln.TryGetValue(board[i], out object columna))
                        throw new InvalidProgramException(board[i].Key.ToString());

                    for (int j = 0; j < N; j++)
                        if (j == int.Parse(columna.ToString()))
                            line += "│¤ ";
                        else
                            line += "│  ";
                    Console.WriteLine(line + "│");

                    if (i == N - 1)
                    {
                        line = "└──";
                        for (int k = 1; k < N; k++)
                            line += "┴──";
                        line += "┘";
                    }
                    else
                    {
                        line = "├──";
                        for (int k = 1; k < N; k++)
                            line += "┼──";
                        line += "┤";

                    }
                    Console.WriteLine(line);
                }
            }
            if (unsolved)
                System.Console.WriteLine("No solution found.");
        }

    }
}