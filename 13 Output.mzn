% Use this editor as a MiniZinc scratch book

include "alldifferent.mzn";

% Todos los pares del 1 al 20

% output [show(x)++ " " | x in 1..20 where x mod 2 == 0 ];

% output [show(x*2)++" " | x in 1..10 ];

%constraint alldifferent(s);


% Todos los divisores para  cada numero del 1 al 10

output [ show(y)++":\t"++ show(x)++"\n" | y,x in 1..10 where y mod x == 0 ];


%output["Divisores: "++show(y)++"\n" ]++
%      [ (if j>=fix(comienzo[i]) /\ j< fix(comienzo[i])+tiempo[i]
%         then "|*"
%         else "| " endif) ++
%        (if j==fix(total)-1
%         then "|\n"
%         else "" endif)       | i in 1..n, j in 0 .. fix(total)-1];

solve satisfy;
