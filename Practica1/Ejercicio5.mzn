% constantes

int:p1x = 4;
int:p1y = 3;

int:p2x = 2;
int:p2y = 1;

int:p3x = 6;

% variables
var 0..7:p3y; % valor de la coordenada y del punto 3

var -20..20:a1;
var -20..20:b1;
var -20..20:a2;
var -20..20:b2;
var -20..20:a3;
var -20..20:b3;

% restricciones

constraint p1y=a1*p1x+b1;
constraint p2y=a1*p2x+b1;

constraint p1y=a2*p1x+b2;
constraint p3y=a2*p3x+b2;

constraint p2y=a3*p2x+b3;
constraint p3y=a3*p3x+b3;



% solve
solve satisfy;
