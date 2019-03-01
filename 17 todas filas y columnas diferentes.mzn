% Use this editor as a MiniZinc scratch book

%Queremos encontrar un array de tamaño NxN con valores de 1..N en el que
%a) Todas las filas son diferentes
% b) Todas las columnas son diferentes
% c) No hay ninguna fila ordenada de forma creciente
% d) No hay ninguna columna ordenada de forma creciente

include "alldifferent.mzn";

int:N=5;
array [1..N,1..N] of var 1..N: a;


%a) Todas las filas son diferentes
constraint forall(i,k in 1..N where i<k)(exists(j in 1..N)(a[i,j]!=a[k,j]));

%esta restriccion no vale ya que eliminamos filas de mas
%constraint forall(j in 1..N)(alldifferent(([ a[i,j] | i in 1..N])));

% b) Todas las columnas son diferentes
constraint forall(i,k in 1..N where i<k)(exists(j in 1..N)(a[j,i]!=a[j,k]));

%esta restriccion no vale ya que eliminamos columnas de mas
%constraint forall(i in 1..N)(alldifferent(([ a[i,j] | j in 1..N])));

% c) No hay ninguna fila ordenada de forma creciente
constraint forall(i in 1..N)(exists(j,k in 1..N where j<k)(a[i,j]>a[i,k]));

% d) No hay ninguna columna ordenada de forma creciente
constraint forall(i in 1..N)(exists(j,k in 1..N where j<k)(a[j,i]>a[k,i]));



% Para mostrar un array de NxN utilizar:
output( [show(a[i,j])++" "++ 
            (if (j==N) then "\n" else " " endif) 
        | i in 1..N,j in 1..N]);
