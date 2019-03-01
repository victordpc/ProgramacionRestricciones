par int:M=100;
par int:N=5;
array [1..N,1..N] of var int: a;

% a) La suma de valores en a sea m
constraint sum(a)==M;

% b) Todos los valores en a estén entre 1 y N
constraint forall([ a[i,j] >0 /\ a[i,j]<=N | i,j in 1..N]);

%% La suma de la primera fila es 20
constraint sum([a[1,j]|j in 1..N])==20;
constraint sum(j in 1..N)(a[1,j])==20;

%% La segunda fila todos son menores que 5
constraint forall([a[2,j]<5|j in 1..N]);

%% Existe al menos un 3 en la matriz
constraint exists(i,j in 1..N)(a[i,j]=3);
% exists Obliga a que se cumple alguna condición de las que se les pasan%

% c) Para todo valor de i de 1 a N, el valor i aparece al menos una vez en a.
constraint forall(k in 1..N)(exists(i,j in 1..N)(a[i,j]=k));
% exists Obliga a que se cumple alguna condición de las que se les pasan%


% d) Los valores en a sean lo más pequeños posibles; si llamamos c al máximo
% de los valores en a, se trata de minimizar c.

solve minimize max(a);

% Para mostrar un array de NxN utilizar:
output( [show(a[i,j])++" "++ 
            (if (j==N) then "\n" else " " endif) 
        | i in 1..N,j in 1..N]);

% solve satisfy;

