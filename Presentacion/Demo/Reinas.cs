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
            CspTerm[] tablero = S.CreateVariableVector(Filas, "Tablero", N);

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

            MostrarSolucion(N, S, tablero);
        }

        private static void MostrarSolucion(int N, ConstraintSystem S, CspTerm[] tablero)
        {
            bool unsolved = true;
            ConstraintSolverSolution soln = S.Solve();
            if (soln.HasFoundSolution)
            {
                unsolved = false;

                string linea = "┌──";
                for (int i = 1; i < N; i++)
                    linea += "┬──";
                linea += "┐";

                Console.WriteLine(linea);

                for (int i = 0; i < N; i++)
                {
                    linea = "";

                    if (!soln.TryGetValue(tablero[i], out object columna))
                        throw new InvalidProgramException(tablero[i].Key.ToString());

                    for (int j = 0; j < N; j++)
                        if (j == int.Parse(columna.ToString()))
                            linea += "│¤ ";
                        else
                            linea += "│  ";
                    Console.WriteLine(linea + "│");

                    if (i == N - 1)
                    {
                        linea = "└──";
                        for (int k = 1; k < N; k++)
                            linea += "┴──";
                        linea += "┘";
                    }
                    else
                    {
                        linea = "├──";
                        for (int k = 1; k < N; k++)
                            linea += "┼──";
                        linea += "┤";

                    }
                    Console.WriteLine(linea);
                }
            }
            if (unsolved)
                System.Console.WriteLine("No solution found.");
        }
    }
}