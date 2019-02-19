% Use this editor as a MiniZinc scratch book

include "alldifferent.mzn";

int :n=5;

array[1..n,1..n] of var 1..10:s;

% Diferentes por filas

constraint forall([ s[f,i]!=s[f,j] | f in 1..n , i in 1..n , j in i+1..n]);

% Diferentes por columnas
constraint forall([ s[i,c]!=s[j,c] | c in 1..n , i in 1..n , j in i+1..n]);
constraint forall(c in 1..n , i in 1..n , j in i+1..n)(s[i,c]!=s[j,c]);

constraint forall(c in 1..n)
             (forall(i in 1..n)
               (forall(j in i+1..n)
                 (s[i,c]!=s[j,c])
             )
           );

% Tres bucles con notacion reducida
constraint forall([ s[i,c]!=s[j,c] | c, i, j in 1..n where i<j]);
constraint forall(c, i, j in 1..n where i<j)(s[i,c]!=s[j,c]);


%constraint alldifferent(s);

solve satisfy;
