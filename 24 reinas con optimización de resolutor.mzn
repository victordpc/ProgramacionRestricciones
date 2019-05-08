
% reinas

int:n=4;

array [1..n] of var 1..n: t;

% constraints

%fila
constraint forall (i in 1..n-1)(forall(j in i+1..n)(t[i]!=t[j]));

% dos diagonales
constraint forall (i in 1..n-1)(forall(j in i+1..n)(t[i]!=t[j]+(j-i)));
constraint forall (i in 1..n-1)(forall(j in i+1..n)(t[i]!=t[j]-(j-i)));

% probar la diferencia
%solve satisfy;
%solve :: int_search(t, first_fail, indomain_min, complete) satisfy;
solve :: int_search(t, input_order, indomain_min, complete) satisfy;

output[ show(t[i])++" " | i in 1..n];
