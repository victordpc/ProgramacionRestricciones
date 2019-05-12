using Microsoft.SolverFoundation.Solvers;

namespace Demo
{
    public class Reinas
    {
        public static void Run(int N)
        {
            //Creamos un sistema de constrains
            ConstraintSystem S = ConstraintSystem.CreateSolver();
            //Creamos un dominio, enteros de 0 a Equipos-1
            CspDomain Filas = S.CreateIntegerInterval(0, N - 1);

            //Matriz con una fila para cada equipo y los valores de los oponentes
            CspTerm[] tablero = S.CreateVariableVector(Filas, "Tablero", N);

            for (int i = 0; i < N; i++)
            {
                for (int j = i + 1; j < N; j++)
                {
                    S.AddConstraints(
                        S.Unequal(tablero[i], tablero[j]) // Fila
                        , S.Unequal(tablero[j] + (j - i), tablero[i]) // Diagonal 1
                        , S.Unequal(tablero[j] - (j - i), tablero[i]) // Diagonal 2
                        );
                }
            }

            bool unsolved = true;
            ConstraintSolverSolution soln = S.Solve();
            if (soln.HasFoundSolution)
            {
                unsolved = false;

                //StringBuilder linea = new StringBuilder("Equipo ");
                //for (int i = 0; i < N; i++)
                //    linea.Append("J" + (i + 1).ToString() + " ");

                //System.Console.WriteLine(linea.ToString());

                //for (int t = 0; t < N; t++)
                //{
                //    StringBuilder line = new StringBuilder("    ");
                //    line.Append(t.ToString());
                //    line.Append(": ");
                //    for (int w = 0; w < N - 1; w++)
                //    {
                //        if (!soln.TryGetValue(partidos[t][w], out object opponent))
                //            throw new InvalidProgramException(partidos[t][w].Key.ToString());
                //        line.Append(opponent.ToString());
                //        line.Append(" ");
                //    }
                //    System.Console.WriteLine(line.ToString());
                //}
                //System.Console.WriteLine();
            }
            if (unsolved)
                System.Console.WriteLine("No solution found.");
        }
    }
}