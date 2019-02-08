%En cierta isla viven dos razas: los M y los V. Los M siempre mienten, los V siempre dicen la
%verdad.Un misionero encuentra a tres individuos A, B, C que dicen:
%A: Exactamente uno de nosotros es un M
%B: Exactamente dos de nosotros son M
%C: Todos somos M
%¿De qué tipo es cada uno?

% constantes
bool:M=true;
bool:V=false;

% variables
var bool:A;
var bool:B;
var bool:C;

% constraint 

constraint A -> A+B+C != 1;
constraint not(A) -> A+B+C==1;

constraint B -> A+B+C != 2;
constraint not(B) -> A+B+C == 2;

constraint C -> A+B+C != 3;
constraint not(C) -> A+B+C == 3;

solve satisfy;

% Truco para resolver este problema
% Podemos poner el enunciado "Lo que dice X" de la forma:
% constraint DiceA == (A+B+C==1)
% constraint if A then not(DiceA) else DiceA endif;
