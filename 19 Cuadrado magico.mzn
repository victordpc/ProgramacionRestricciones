% 2) Cuadrados mágicos. Dado un cuadrado de 1 a N, colocar los números 1,2….N^2 de forma que todas las filas y columnas sumen la misma cantidad
include "alldifferent.mzn";

int:N=3;
int:numero=N*N;

var int:suma;

array [1..N,1..N] of var 1..numero: t;

% todas las filas y columnas sumen la misma cantidad
%constraint suma=sum(i in 1..N)(t[1,i]);

% 3) Modificar el modelo anterior sabiendo que la suma es n(n^2 +1)/2
constraint suma=N*(pow(N,2)+1)/2;

constraint forall(fila in 1..N)(sum(columna in 1..N)(t[fila,columna])==suma);
constraint forall(columna in 1..N)(sum(fila in 1..N)(t[fila,columna])==suma);
constraint sum(i in 1..N)(t[i,N+1-i])==suma;
constraint sum(i in 1..N)(t[i,i])==suma;
constraint alldifferent(t);

output(
  [show(t[i,j]) ++
  (if (j==N) then "\n" else " " endif) | i in 1..N,j in 1..N]);