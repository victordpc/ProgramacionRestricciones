% Use this editor as a MiniZinc scratch book
include "alldifferent.mzn";
include "lex_less.mzn";
include "cumulative.mzn";

%% All diferent
%var -1..1:x;
%constraint alldifferent([x,x*x]);

% lex_less

% Cumulative
% Cumulative(array[int] of var int: s, array[int] of var int: t, array[int] of var int: r, var int: k)

%Planificación de proyectos.
%Una empresa tiene que desarrollar 4 aplicaciones. Para ello dispone de 5 programadores, y suponemos que cada programador se dedica a una sola aplicación en cada momento. Cada aplicación tarda un tiempo determinado en realizarse y requiere una cantidad prefijada de programadores. Se trata de minimizar el tiempo que se requiere para acabar los 4 programas. 

%int:n=4; % total programas
%int:k=5; % total recursos (programadores)

%int:max_tiempo=sum(tiempo); % limite superior de tiempo

%array[1..n] of int:tiempo=[2,4,6,3]; % tiempo que se tarda en hacer cada tarea
%array[1..n] of int:prog=[3,2,4,2]; % recursos que se usan en cada tarea

%array[1..n] of var 0..max_tiempo:comienzo; % momento de inicio de cada tarea
%var  0..max_tiempo:  total;  %tiempo total de trabajo


% Cumulative
%constraint cumulative(comienzo, tiempo, prog, k); % llamada a la restriccion cumulative

% aseguramos que se acaba lo antes posible
%constraint forall(i in 1..n)(comienzo[i]+tiempo[i]<=total); 
%solve minimize total;
% aseguramos que se acaba lo antes posible

%output["Tiempo total: "++show(total)++"\n" ]++
%      [ (if j>=fix(comienzo[i]) /\ j< fix(comienzo[i])+tiempo[i]
%         then "|*"
%         else "| " endif) ++
%        (if j==fix(total)-1
%         then "|\n"
%         else "" endif)       | i in 1..n, j in 0 .. fix(total)-1];

%% Ejemplo mudanza
%int: n=8; % number of objects;

%set of int: OBJECTS = 1..n;

%array[OBJECTS] of int: duration= [60, 45, 30, 30, 20, 15, 15, 15]; % duration to move
%array[OBJECTS] of int: handlers= [3, 2, 2, 1, 2, 1, 1, 2]; % number of handlers required
%array[OBJECTS] of int: trolleys= [2, 1, 2, 2, 2, 0, 0, 1]; % number of trolleys required

%int: available_handlers=4;
%int: available_trolleys=3;
%int: available_time=180;

%array[OBJECTS] of var 0..available_time: start;

%var 0..available_time: end;

%constraint cumulative(start, duration, handlers, available_handlers);
%constraint cumulative(start, duration, trolleys, available_trolleys);

%constraint forall(o in OBJECTS)(start[o] +duration[o] <= end);

%solve minimize end;

%output [ "start = ", show(start), "\nend = ", show(end), "\n"];


%% Predicado table
%% Sintaxis:
%% table(array[int] of var bool: x, array[int, int] of bool: t)
%% table(array[int] of var int: x, array[int, int] of int: t)

%% Ejemplo: Queremos comprarnos dos coches. Para elegir tenemos entre unas cuantas posibilidades. Queremos que uno de los coches, que utilizaremos para ir al trabajo, tenga al menos 180 caballos, y que pase de 0 a 140 km/h en menos de 20 segundos. Para el otro coche, que utilizaremos los fines de semana, no tenemos ninguna limitación, pero no podemos gastarnos en total más de 50000 euros. Tenemos 6 modelos para elegir


%include "table.mzn";

%%%% parametros
%int: n=6; % Modelos para elegir 
%int: numparam = 4;
%set of int: COCHES=1..n;
%set of int: ATRIBUTOS=1..numparam; % Atributos de los coches

%int: maxdinero=50000;
%int: mincaballos=180;
%int: maxtiempo=2000;

%array[COCHES] of string: nombres= ["Alfa Romeo 147 GTA",
%           "Audi A4 1.8",
%           "Cadillac CTS 2.6",
%           "Citroen C4 2.0 Hdi",
%           "Ford Focus TDCI",
%           "Renault Clio Sport 2.0"]; %Nombres de los coches
%array[COCHES,ATRIBUTOS] of int: datos
%      = [| 1,      250,      1171,  31500 % Alfa Romeo 147 GTA
%         | 2,      125,      2403,  26800 % Audi A4 1.8
%         | 3,      181,      1822,  36800 % Cadillac CTS 2.6
%         | 4,      136,      1828,  21000 % Citroen C4 2.0 Hdi
%         | 5,      115,      2244,  19000 % Ford Focus TDCI
%         | 6,      182,      1450,  17000 % Renault Clio Sport 2.0
%         |]; % Datos de los coches

%%%% variables de decision
%% coche para ir cada dia al trabajo
%array[ATRIBUTOS] of var int:trabajo;

%% coche para el fin de semana
%array[ATRIBUTOS] of var int:findesemana;

%% restricciones
%constraint trabajo[4] + findesemana[4] <= maxdinero;
%constraint trabajo[2] >= mincaballos;
%constraint trabajo[3] < maxtiempo;
%constraint trabajo[1] != findesemana[1];
%constraint table(trabajo,datos);
%constraint table(findesemana,datos);

%solve satisfy;

%output([show(nombres[fix(trabajo[1])])]++[": "]++
%                 [show(trabajo[i])++" " | i in 2..numparam]++["\n"]++
%       [show(nombres[fix(findesemana[1])])]++[": "]++
%                 [show(findesemana[i])++" " | i in 2..numparam]
%       );

%% Predicado regular -> Automatas como los de FC

%%Sintaxis:
%%regular(array[int] of var int: x, int: Q, int: S, array[int,int] of int: d, int: q0, set of int: F);

% Q es su número de estados. 
% Valores de entrada en el rango 1..S. 
% Función de transición d (que establece una correspondencia entre [1..Q]x[1..S] a [0..Q] 
% Estado inicial q0 (valor en 1..Q) 
% Estados de aceptación en F q0 (valores en 1..Q) 

%Ejemplo:Tenemos un juego en el que la casilla 1 es la de inicio y la casilla 5 es la de llegada. Se juega con un dado con las siguientes reglas:
%Desde la casilla 1, con una tirada de 3 se pasa a la casilla 2, y con una tirada de 5 a la casilla 3. Con el resto de los valores la ficha no se mueve.
%De la casilla 2 se pasa a la 3 con valores 3,4,5,6. Pero si se sacan 3 veces seguidas 1 o 2 se vuelve al comienzo.
%De la casilla 3 se pasa a la 4 con 6, a la 2 con un 2 y a la 1 con el resto de valores.
%De la casilla 4 se pasa a la 5 con 4,5,6. Si sale un valor 1,2,3 el jugador debe abandonar la partida 

%include "regular.mzn";

%int: Q = 7;
%int: S = 6;
%int: q0 = 1;
%set of int: qf = {7};
%set of int: ESTADOS = 1..Q;
%set of int: DADO = 1..S;
%array[ESTADOS,DADO] of int: d =
%    [| 1,1,2,1,3,1 % q1
%     | 4,4,3,3,3,3 % q2
%     | 2,2,1,1,1,6 % q3
%     | 5,5,3,3,3,3 % q4
%     | 1,1,3,3,3,3 % q5
%     | 0,0,0,7,7,7 % q6
%     | 0,0,0,0,0,0 % q7
%     |];
%array[1..5] of var 1..S: s;

%constraint regular(s,Q,S, d,q0,qf);

%solve satisfy;

%output[show(s)];

%% Circuit

% Tiene como parámetro un vector.
% circuit([x1,...,xn])
%xi = j significa que se visitará el nodo j tras el nodo i.

%Los elementos representan un recorrido de un grafo, y la restricción obliga a que sea un recorrido hamiltoniano, es decir que todos los nodos se visiten una vez.
% ¿Qué soluciones tendrán los siguientes modelos con un solo constraint?
%M1: constraint circuit([2,3,4,1]);
%M2: constraint circuit([2,1,4,3]);
%M3: constraint circuit([2,3,4,3]);

include "circuit.mzn";

array [1..4] of var 1..4:a;
constraint circuit(a);





