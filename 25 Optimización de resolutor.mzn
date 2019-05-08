% Use this editor as a MiniZinc scratch book

var 1..10:x;
var 1..10:y;

constraint x<2*y;

% 2y-x sea lo mayor posible y dentro de eso    ---- Hard constraint
% que y sea lo menor posible                   ---- Soft constraint
% y si fuera posible x==10 /\ y>5              ---- Soft constraint

var int:o1;
constraint o1=-(2*y-x);

var int:o2;
constraint o2=y;

%var bool:s1;
%constraint s1= if x==10 /\ y>5 then false else true endif;

var 0..1:s1;
constraint s1== not(y<5);

solve :: int_search([s1,o1,o2,x,y], input_order, indomain_min, complete)  satisfy;
