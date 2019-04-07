
int:n=10;
int:masgrande=1000;

% Declaracion de conjuntos
set of int:r={1,2,5};
set of int:s = 1..n;
set of int:elementos = 1..masgrande;

% t es un entero con un dominio que puede coger los valores del conjunto (con huecos)
var {3,5,7}:t;

% Como el conjunto esta declarado y es un rando al fin de cuentas
% Se puede declarar el array con el conjunto
array [s] of var 1..1000:u;
array [s] of var 1..1000:v;

% No se puede usar el conjunto r para declarar un array por que tiene huecos
% array [r] of var 1..1000:w;
% Pero si se puede usar el conjunto con huecos para declarar el dominio del array
array [s] of var r:w;

% Tambien se puede usar como un rango para las operaciones
constraint forall(i in s)(u[i]>i*v[i] /\ v[i]>i);

solve satisfy;

output [ "u["++show(i)++"]= "++show(u[i])++
         " v["++show(i)++"]= "++show(v[i])++"\n" | i in s]
         
         