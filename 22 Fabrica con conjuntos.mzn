
% Number of different products
int: nproducts=2;
set of int: Products = 1..nproducts;

%profit per unit for each product
array[Products] of int: profit = [400, 450];
array[Products] of string: pname = ["banana-cake", "chocolate-cake"];

%Number of resources
int: nresources=5;
set of int: Resources = 1..nresources;

%amount of each resource available
array[Resources] of int: capacity= [4000, 6, 2000, 500, 500];
array[Resources] of string: rname= ["flour","banana","sugar","butter","cocoa"];

%units of each resource required to produce 1 unit of product
array[Products, Resources] of int: consumption= 
    [| 250, 2,  75, 100,  0, 
     | 200, 0, 150, 150, 75, |];

array [Products] of var int:cuantos;

% Controlamos que no gastemos mas de lo que tenemos
array[Resources] of var int:gastados;
%Rellenamos un array con los gastos de cada producto
constraint forall(i in Resources)
                 (gastados[i]
                   =sum(j in Products)
                       (consumption[j,i]*cuantos[j]));
constraint forall(i in Resources)(gastados[i]<=capacity[i]);

% seguramos que no podemos fabricar un numero negativo de productos
constraint forall(i in Products)(cuantos[i]>=0);

% Maximizamos el dinero
var int:ganancia;
solve maximize ganancia;

constraint ganancia = sum(j in Products)(cuantos[j]*profit[j]);


% Salida
output (["Ganado "++ show(ganancia/100)++" Euros\n"]);
output ([ pname[i]++" "++show(cuantos[i])++"\n" |i in Products]);
output (["Restante \n"]);
output ([ rname[i] ++": " ++ show(capacity[i]-gastados[i]) ++"; " |i in Resources]);



