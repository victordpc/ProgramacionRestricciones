
% reinas
int:n=8;
array [1..n] of var 1..n: t;

% constraints

%fila
constraint forall (i in 1..n-1)(forall(j in i+1..n)(t[i]!=t[j]));

% dos diagonales
constraint forall (i in 1..n-1)(forall(j in i+1..n)(t[i]!=t[j]+(j-i)));
constraint forall (i in 1..n-1)(forall(j in i+1..n)(t[i]!=t[j]-(j-i)));

solve satisfy;

output[ show(t[i])++" " | i in 1..n];