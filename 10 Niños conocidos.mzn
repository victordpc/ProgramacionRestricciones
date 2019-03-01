% 4) En cierto campamento con 10 niños se sabe que siempre que coges 4 al azar hay uno que conoce a los otros 3. ¿Cuántos niños conoce el niño con más conocidos ? ¿y el que menos conocidos tiene?
%Nota: suponer que todo niño se conoce a si mismo.

int:N=10;
array [1..N,1..N] of var bool:t;
array [1..N] of var int:amigos;

var int:MaxConocidos;
var int:MinConocidos;

constraint forall(i in 1..N)(t[i,i]=true);

constraint forall(a,b,c,d in 1..N where a>b /\ b>c /\ c>d)
  (
    exists(i in [a,b,c,d])(t[i,a] /\ t[i,b] /\ t[i,c] /\ t[i,d])
  );

constraint forall(i in 1..N)(amigos[i]=sum(j in 1..N)(t[i,j]));
constraint MaxConocidos = max(amigos);
constraint MinConocidos = min(amigos);


%constraint MaxConocidos = max(sum(columna,fila in 1..N)(t[fila,columna]));

%constraint MinConocidos = min(forall(fila in 1..N)(sum(columna in 1..N)(a[fila,columna])));

%constraint forall(i in 1..N)(amigos[i]>3)
%constraint forall(i in 1..N)()

output ["Maximo de conocidos: " ++ show(MaxConocidos) ++ "\nMinimo conocidos: " ++ show(MinConocidos) ++ "\n\n"];
output[show(amigos) ++ "\n\n"];
output[show(if (t[i,j]) then 1 else 0 endif)++
  (if (j==N) then "\n" else " " endif) | i in 1..N,j in 1..N];

  