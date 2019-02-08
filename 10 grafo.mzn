% Colocar en los nodos valores del 1 al 8 de forma que dos nodos adyacentes no tengan
% valores consecutivos


include "alldifferent.mzn";
constraint alldifferent([A,B,C,D,E,F,G,H]);

% variables

var 1..8:A;
var 1..8:B;
var 1..8:C;
var 1..8:D;
var 1..8:E;
var 1..8:F;
var 1..8:G;
var 1..8:H;

% constraint


constraint abs(A-B)!=1;
constraint abs(A-C)!=1;
constraint abs(A-D)!=1;
constraint abs(B-C)!=1;
constraint abs(B-F)!=1;
constraint abs(B-E)!=1;
constraint abs(C-D)!=1;
constraint abs(E-C)!=1;
constraint abs(F-C)!=1;
constraint abs(G-C)!=1;
constraint abs(D-F)!=1;
constraint abs(D-G)!=1;
constraint abs(E-F)!=1;
constraint abs(E-H)!=1;
constraint abs(G-F)!=1;
constraint abs(H-F)!=1;
constraint abs(H-G)!=1;

solve satisfy;