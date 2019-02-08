%constantes
var int:nc;

%variables
var int:A;
var int:B;
var int:C;
var int:D;
var int:E;

%restricciones
constraint A>=1 /\A<=nc;
constraint B>=1 /\B<=nc;
constraint C>=1 /\C<=nc;
constraint D>=1 /\D<=nc;
constraint E>=1 /\E<=nc;

constraint A!=C /\ B!=C /\ D!=C /\ C!=E;
constraint D!=E;
constraint B!=D;
constraint B!=E;
constraint A!=E;
constraint A!=B;
constraint A!=D;

% si usamos /\ equvale a un and
% constraint A!=C;
% constraint B!=C;
% constraint D!=C;
% constraint C!=E;

%resolver
solve minimize nc;