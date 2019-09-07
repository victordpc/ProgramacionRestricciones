% Use this editor as a MiniZinc scratch book
float:longTotal=180.0;
float:distanciaCubrir=60.0;

var 0.0..18000.0:longSubida;
var 0..longTotal:longValle;

var 13..17:numeroSubidas;
var 12..18:numeroValles;

%constraint longTotal-1 <= numeroSubidas*2*longSubida + numeroValles*longValle;
%constraint longTotal+1 >= numeroSubidas*2*longSubida + numeroValles*longValle;

constraint longSubida = ((numeroSubidas*2)*longSubida) + numeroValles*longValle;

constraint distanciaCubrir=numeroValles*longValle;

constraint numeroSubidas=numeroValles +1;

constraint longSubida > 0.0 /\ longValle > 0.0;
constraint numeroSubidas > 0 /\ numeroValles > 0;

%constraint numeroSubidas >=13 /\ numeroSubidas <= 17;

constraint longValle > longSubida;


%output [show(numeroSubidas*2*longSubida+numeroValles*longValle)]