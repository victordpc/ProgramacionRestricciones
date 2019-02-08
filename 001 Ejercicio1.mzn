
% constantes
bool:mentira=true;
bool:caballero=not(mentira);
bool:duende=mentira;

% variables
var bool:A;
var bool:B;
var bool:DiceA;
var bool:DiceB;
% restricciones
constraint DiceA==(B==duende);
constraint DiceB==(A==duende);
constraint if A then not(DiceA) else DiceA endif;
constraint if B then not(DiceB) else DiceB endif;
% solve
solve satisfy;

