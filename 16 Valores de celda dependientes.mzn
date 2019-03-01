%Queremos encontrar un array de tamaño NxN con valores de 1..N en el que:
%- Si una casilla de una fila>1 contiene el valor N, la casilla de arriba (misma columna,  fila una menos) tiene que ser un 1.
% - Si una casilla de una columna c, 1<c<N contiene un valor par p, entonces las casillas  de la izquierda y de la derecha contienen los valores p-1 y p+1, respectivamente
% - Todos los números 1..N aparecen al menos 2 veces en el array
%Queremos encontrar un array t de tamaño NxN en los que cada casilla puede tomar los valores 0,2,3 o 5. En particular, la casilla t[i,j] contendrá k con k en {2,3,5} si i+j es divisible entre k, o 0 en caso contrario.
int:N=5;
array [1..N,1..N] of var 1..N: a;

%- Si una casilla de una fila>1 contiene el valor N, la casilla de arriba (misma columna,  fila una menos) tiene que ser un 1.
constraint  forall(i in 2..N,j in 1..N)
  (a[i-1,j] = 
      if (a[i,j]==N) then 1
      else a[i-1,j] endif
  );

% - Si una casilla de una columna c, 1<c<N contiene un valor par p, entonces las casillas  de la izquierda y de la derecha contienen los valores p-1 y p+1, respectivamente
constraint forall(i in 1..N, j in 2..N-1)
        (if (a[i,j] mod 2 == 0) then a[i,j-1]=a[i,j]-1 /\ a[i,j+1]=a[i,j]+1 endif
        );

% - Todos los números 1..N aparecen al menos 2 veces en el array
constraint 
  forall(k in 1..N)(
    sum(i,j in 1..N)(if (a[i,j]=k) then 1
    else 0 endif) >=2
    );

% Para mostrar un array de NxN utilizar:
output( [show(a[i,j])++" "++ 
            (if (j==N) then "\n" else " " endif) 
        | i in 1..N,j in 1..N]);
