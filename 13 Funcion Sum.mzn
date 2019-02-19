
%int: n=5;
%array[1..n] of var 1..10:s;
% % array sin el valor 5
% constraint forall([s[x]!=5 | x in 1..n]);
% Otra forma de escribir el for
% constraint forall(i in 1..n)(s[i]!=5);

int:k=5;
array [1..k] of var bool:b;
% el array solo tiene un True
constraint sum(b)==1;


int:l=5;
array [1..l] of var 1..10:c;
array [1..l] of var bool:d;

% el array tiene exactamente 2 valores iguales
constraint forall ( x,y in 1..l where x<y )( if c[x]==c[y] then d[x]=true else d[x]==false endif);
constraint sum(d)==2;

% otra forma
constraint sum( [c[i]==c[j] | i,j in 1..k where i<j] ) == 1;

solve satisfy;