% constantes

% variables
var 1..3:casimira;
var 1..3:herminia;
var 1..3:bertoldo;

var bool:preguntaUno;
var bool:preguntaDos;
var bool:preguntaTres;

% restricciones
constraint casimira >0 /\ herminia>0 /\ bertoldo>0;

constraint preguntaUno == (casimira>herminia);
constraint preguntaDos == (herminia>bertoldo);
constraint preguntaTres ==(casimira>bertoldo);

constraint  preguntaUno /\ preguntaDos -> preguntaTres;

% solve
solve satisfy;
