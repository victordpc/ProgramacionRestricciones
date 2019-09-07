%constantes

%variables
var int:A;
var int:B;
var int:C;
var int:D;

%restricciones
constraint A*0.6=B*4 /\ B*4=C*1 /\ D=C;
constraint A>0 /\ B>0 /\ C>0 /\D>0;
constraint A+B+C+D>90;
constraint A+B+C+D<110;
% si usamos /\ equvale a un and
% constraint A!=C;
% constraint B!=C;
% constraint D!=C;
% constraint C!=E;

%resolver
solve satisfy;