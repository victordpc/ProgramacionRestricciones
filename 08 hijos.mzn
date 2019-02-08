% La madre intenta averiguar cuál de los 3 hijos, Bertoldo,
% Herminia o Aniceto, ha roto el valioso jarrón chino con la pelota. He aquí sus declaraciones:
% - Aniceto: Bertoldo y Herminia son tan culpables el uno como el otro
% - Bertoldo: Si Aniceto es culpable, también lo soy yo
% - Herminia: Bertoldo y yo, no somos los dos culpables.
% La madre sabe que son traviesos pero no mentirosos. Haz un modelo MiniZinc para
% encontrar al/los culpables.

% constantes

% variables

var bool:Bertoldo;
var bool:Herminia;
var bool:Aniceto;

%restricciones

constraint Bertoldo==Herminia;
constraint Aniceto -> Bertoldo;
constraint not (Bertoldo /\ Herminia);

solve satisfy;