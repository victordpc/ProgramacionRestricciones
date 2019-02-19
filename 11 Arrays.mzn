% Use this editor as a MiniZinc scratch book

include "alldifferent.mzn";

%int:n=10;
% array [1..3] of var 1..n: s; % array con valores de 1 a n de tres posiciones

% % da error por que un elemento del array es 7 que no esta en el rango de 8 a n
%int:n=10;
% array [1..3] of var 8..n: s=[_,7,_]; % array con valores de 8 a n de tres posiciones con un 7 en la segunda posicion

%int:n=10;
% array [1..3] of var 8..n: s=[_,8,_]; % array con valores de 8 a n de tres posiciones con un 8 en la segunda posicion

% % Arrays de dos dimensiones (tres filas dos columnas)
% array [1..3,1..2] of var 0..500: s = [ | _,7 |_,_ | _,_ |]; % array con valores de 8 a n de tres posiciones con un 7 en la segunda posicion
% array [1..3,1..2] of var 0..500: s = [ | 1,2, | 4,_, | _,_ |];


% Listas intensionales 
% Lista intensional : [exp | generador]
% generador genera valores
% exp acumula los valores

% Es un bucle -> for de 1 a 5 metelo en la lista con un espacio detras
% output [show(x*x)++" " | x in 1..5];

int :n=5;

array[1..n] of var 1..10:s;

% forall es cierto si todos los elementos de la lista es cierto
% constraint forall([ s[i]<s[i+1] | i in 1..n-1]);

constraint forall([ s[i]!=s[j] | i in 1..n , j in i+1..n ]);


%constraint alldifferent(s);

solve satisfy;