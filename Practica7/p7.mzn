% Alumno1: Victor del Pino Castilla
% Alumno2: Leila Ruiz Casanova
%%%%%% Poner aquí los include necesario
include "cumulative.mzn";
include "circuit.mzn";
%%%%%%% Esto no se toca %%%%%%%

int:N=6;  % total de camiones
set of int: CAMIONES=1..N;

int:D=13;
set of int:DESTINOS=1..D;
array [DESTINOS, 1..4] of int:d  = 
%         ind, Nºcamiones Tiempo Destino
        [|  1,     1,     4,       7, 
         |  2,     2,     3,       8,
         |  3,     3,     4,       4,
         |  4,     2,     5,      10,
         |  5,     4,     3,       9,
         |  6,     5,     2,       2,
         |  7,     2,     2,      11,
         |  8,     6,     2,      12,
         |  9,     1,     6,       1,
         | 10,     4,     2,       5,
         | 11,     3,     2,       6,
         | 12,     2,     2,      13,
         | 13,     3,     2,       3,
         |];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Una compañía de transportes dispone de N camiones, con los que tiene realizar D
% viajes. Llamamos DESTINOS al conjunto con el rango 1..D Disponemos además de un
% array d de tamaño D x 3. Cada fila tiene los datos de un viaje: un índice de fila, el
% número de camiones necesarios, y el tiempo en dias (tiempo total, ida+vuelta).
% Queremos organizar en qué día debe se realizará cada viaje, para que se acabe lo
% antes posible con todos los destinos, asegurando siempre que hay caminos suficientes
% para el viaje requerido.

% 1 Vamos a declarar el vector t de tamaño DESTINOS que contenga el tiempo
% requerido cada viaje. Este vector será una copia exacta de la tercera columna de d.
% Declarar t y asegurarse de que, en efecto, corresponde con la tercera columna de d.

array [DESTINOS] of var int:t=[d[i,3]|i in DESTINOS];
%constraint forall(i in DESTINOS)(t[i]=d[i,3]);

% 2 Ahora declaramos el array s de tamaño DESTINOS, que tiene el día en el que
% partirá cada viaje
% a. Declarar el array
% b. La restricción que asegura que son todos valores >= 0

array [DESTINOS] of var 0..sum(i in DESTINOS)(d[i,3]):s;
constraint forall(i in DESTINOS)(s[i]>=0);

% 3 Finalmente tenemos que declarar el vector r de tamaño DESTINOS con los
% camiones que necesita cada viaje
% a. Declarar el array
% b. La restricción que hace que contenga la segunda columna de d

array [DESTINOS] of CAMIONES:r=[d[i,2] | i in DESTINOS];
%constraint forall(i in DESTINOS)(r[i]=d[i,2]);

% 4 Añadir la restricción cumulative correspondiente y el solve satisfy. La salida será
% del estilo (puede variar, según las restricciones):
% t = array1d(1..13 ,[4, 3, 4, 5, 3, 2, 2, 2, 6, 2, 2, 2, 2]);
% s = array1d(1..13 ,[11, 8, 0, 0, 8, 13, 17, 6, 0, 11, 15, 15, 4]);
% r = array1d(1..13 ,[1, 2, 3, 2, 4, 5, 2, 6, 1, 4, 3, 2, 3]);

constraint cumulative(s, t, r, N);

%solve satisfy;

% 5  Ahora queremos minimizar el tiempo. Para esto declararemos:
% a. Un vector de DESTINOS con variables de 1 a SUM_T de nombre a, con

array [DESTINOS] of var SUM_T:a;

% SUM_T la suma de lo que tardan todos los viajes

set of int: SUM_T=1..sum(i in DESTINOS)(d[i,3]);
%var int:SUM_T = sum(t);
%var int:SUM_T = sum([t[i]|i in DESTINOS]);
%constraint SUM_T=sum(i in DESTINOS)(d[i,3]);

% b. Una restricción que asegura que a[i] es el momento en que acaba la tarea i
% La salida será de la forma:
% a = array1d(1..13 ,[15, 11, 4, 5, 11, 15, 19, 8, 6, 13, 17, 17, 6]);

constraint forall(i in DESTINOS)(a[i]=s[i]+t[i]);

% 6 Ahora :
% a. Declaramos una variable entera fin
var int:fin;
% b. Una restricción que asegura que fin es el máximo de a
constraint fin=max(a);
% c. Comentamos el solve satisfy, y añadimos la restricción que hace que el
% tiempo que se tarda en completar todos los viajes es mínimo.
% Posible salida:
% t = array1d(1..13 ,[4, 3, 4, 5, 3, 2, 2, 2, 6, 2, 2, 2, 2]);
% s = array1d(1..13 ,[13, 8, 0, 0, 8, 13, 15, 6, 0, 11, 15, 11, 4]);
% r = array1d(1..13 ,[1, 2, 3, 2, 4, 5, 2, 6, 1, 4, 3, 2, 3]);
% a = array1d(1..13 ,[17, 11, 4, 5, 11, 15, 17, 8, 6, 13, 17, 13, 6]);
% fin = 17;
solve minimize fin;

% 7 Añadir un constraint que asegure que los destinos (cuarta columna de d) forman
% un circuito hamiltoniano.

constraint circuit([d[i,4]|i in DESTINOS]);

% 8 Queremos mostrar la salida de forma que indique para cada viaje el mes de
% comienzo y los meses que ocupa en forma de cronograma.


output(["\n\n\n"]);
output["Tiempo total: "++show(fin)++"\n" ]++
      [ (if j>=fix(s[i]) /\ j< fix(s[i])+fix(t[i])
         then "|*"
         else "| " endif) ++
        (if j==fix(fin)-1
         then "|\n"
         else "" endif)       | i in DESTINOS, j in 0 .. fix(fin)-1];
