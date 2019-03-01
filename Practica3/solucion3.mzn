#Nombre1:Víctor del Pino  
#Nombre2:Leila Ruiz Casanova

#Observaciones:

#P1 Modelo:
int:n=6;

array [1..n] of var 1..n: s;
array [1..n] of var 1..n: t;

% a. t contiene elementos diferentes entre sí.
constraint forall(i,j in 1..n where i!=j)(t[i]!=t[j]);

% b. t y s difieren al menos en una posición (t[i]!=s[i] para algún i)
constraint exists(i in 1..n)(s[i]!=t[i]);

% c. Existe un valor k entre 1 y n, tal que s[i] = t[((i+k) mod n) +1] para todo i=1..n. Escribir un modelo que genere pares de vectores rotados.
constraint exists(k in 1..n)(forall(i in 1..n)(s[i]=t[((i+k) mod n) +1]));

#P2 Modelo:
int:n=6;

array [1..n] of var 1..n:t;

% a. Esta formado por elementos distintos.
constraint forall(i,j in 1..n where i!=j)(t[i]!=t[j]);

% b. No está ordenado crecientemente, es decir existen un par de índices i,j=1..n tales que i<j pero t[i]>t[j]
constraint exists(i,j in 1..n where i<j)(t[i]>t[j]);

% c. Todo número tiene un divisor más adelante en el propio vector. Es decir para todo i=1...n-1 existe un j en i+1..n tal que t[j] es divisor de t[i]
constraint forall(i in 1..n-1)(exists(j in i+1..n)((t[i] mod t[j])==0));

#P3 Modelo:
int:n=6;
array [1..n] of var 1..n:t;

% a. Las tareas con ids 4,5,6 se deben realizar consecutivas y en este orden.
constraint t[4] == t[5]-1 /\ t[5] == t[6]-1;

% b. La tarea con id 2 debe ser la primera.
constraint t[2]==1;

% c. Ninguna tarea se hará en la posición que indica su identificador. Es decir, la tarea con id 1 no puede ser la primera, la tarea con id 2 no puede ser la segunda y así sucesivamente.
constraint forall(i in 1..n-1)(t[i]!=i);

% d. La tarea 4 tiene que realizarse más tarde que las 3 y 2 (no inmediatamente ni a continuación, solo “detrás” en algún momento).
constraint t[4]>t[3] /\ t[4] > t[2];

#P4 Modelo:


% Use this editor as a MiniZinc scratch book
int:N=6;
array [1..N,1..N] of var bool:t;

var int:reinas;


constraint forall(i,j in 1..n)(
  t[i,j]=
    if ( 
%    suma de diagonales y ortogonales 
    )=3 then 1
    else 0 endif
  );

constraint reinas==sum(t);
solve maximize reinas;

output["Reinas en el tablero: " ++ show(reinas)];
output( [show(if t[i,j] then 1 else 0 endif)++" "++ 
            (if (j==N) then "\n" else " " endif) 
        | i in 1..N,j in 1..N]);