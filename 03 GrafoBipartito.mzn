%constantes

%variables
var bool:A;
var bool:B;
var bool:C;
var bool:D;
var bool:E;

%restricciones
constraint A!=C /\ B!=C /\ D!=C /\ C!=E;
constraint D!=E;

% si usamos /\ equvale a un and
% constraint A!=C;
% constraint B!=C;
% constraint D!=C;
% constraint C!=E;

%resolver
solve satisfy;