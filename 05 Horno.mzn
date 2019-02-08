
%    dias  hierro  carbon  precio
% A  3     14      2       18.5
% B  4     2.1     11      20.7

% Tenemos
% 15 dias
% 40 hierro
% 13 carbon

% constantes
int:dias=15;
float:precioA=18.5;
float:precioB=20.7;

% variables
var int:ganancia; %cuanto gano
var int:A;          %cuanto A produzco
var int:B;          %cuanto B produzco
var int:diastrabajo;
% restricciones
constraint ganancia=precioA*A+precioB*B;
constraint A*3+B*4<=dias;
constraint A>0 /\ B>0;
constraint diastrabajo<=dias;

% salida
solve maximize ganancia;

