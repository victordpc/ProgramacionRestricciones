
include "alldifferent.mzn";
constraint alldifferent([tenis,futbol,baloncesto,rugby]);

% constantes
int:totalPelotas=14;

% variables
var 2..5:tenis;
var 2..5:futbol;
var 2..5:baloncesto;
var 2..5:rugby;

% restricciones
constraint tenis+futbol+baloncesto+rugby==totalPelotas;
constraint tenis>0 /\ futbol>0 /\ baloncesto>0 /\ rugby>0;

constraint tenis< futbol;
constraint rugby=baloncesto+3;

% solve
solve satisfy;

