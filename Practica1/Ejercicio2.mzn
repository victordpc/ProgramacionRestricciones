
% constantes
bool:verdad=true;
array [1..8]of bool:dias = [verdad,not(verdad),verdad,not(verdad),not(verdad),verdad,not(verdad),verdad];

% variables
var 1..6:hoy;
var bool:diceHoy;

% restricciones
constraint diceHoy==(dias[hoy+1]==verdad);

constraint if dias[hoy] then diceHoy else not(diceHoy) endif;

% solve
solve satisfy;
