% Nombre1: Víctor del Pino
% Nombre2: Leila Ruiz Casanova

%%%%%%%%%%%%%%%%%%%%%%%% no tocar %%%%%%%%%%%
% num ciudades
int:n=5;
% longitud max. del recorrido
int:max=n;
int:FLAG=0;
% dinero que cuesta ir de x a y: t[x,y]
array [1..n,1..n] of int:t=
  [|    0, 100,  10,  420,   0 |
       50,   0,   0,   0,   0 |
        0,   0,   0, 200,  75 |
      150, 100,   0,   0,   0 |
        0, 100,   0, 120,   0 |];
        
int:nentregas=4;
% cada fila es de la forma origen,fin,número de paquetes
array [1..nentregas,1..3] of int:entregas = 
   [| 1,2,5 |
      2,4,3 |
      4,3,50 |
      1,5,6 |];

%%%%%%%%%%


%ciudad origen
int:ini=2;
%ciudad destino
int:fin=4;
%%%%%%%%%%%%%%%%%%%%%%%%%%% Solución 
        
%1) declarar el array 'trayecto' de tamaño 1..max y valores de 0..n
array [1..max] of var 0..n:trayecto;
% declarar posfin, la longitud real del trayecto.
var 2..max:posfin;

% 2) La primera ciudad del trayecto sera ini, la última (posición posfin) ser fin
constraint trayecto[1]==ini /\ trayecto[posfin]==fin;

% 3) restricción para todo i>posfin trayecto[i]=FLAG y si i<=posfin, trayecto[i]!=FLAG
constraint forall(i in 1..max)(if i>posfin then trayecto[i]==FLAG else trayecto[i]!=FLAG endif);
        
% 4) los valores en trayecto desde 1 hasta posfin ambos incluidos, deben ser diferentes
constraint forall(i,j in 1..posfin where i<j)(trayecto[i]!=trayecto[j]);

% 5)  dos posiciones consecutivas en el tramo 1..posfin deben cumplir 
% que hay camino entre ellas
constraint forall(x in 2..posfin)(t[trayecto[x-1],trayecto[x]]!=0);

% 6 array coste
% Vamos a declarar ahora un array coste, desde 1..max-1 (el coste es por cada trayecto).
% Asegurarse de que coste tiene el valor FLAG desde posfin inclusive en adelante.
array [1..max-1] of var int:coste;

% 7 constraint para rellenar el cose
constraint forall(x in 1..max-1)(if x<posfin then coste[x]=t[trayecto[x],trayecto[x+1]] else coste[x]=FLAG endif);

% 8 Declararse una variable costetotal, hacer que tenga el valor del coste total del trayecto y escribir un objetivo que minimize el coste total.
var int:costetotal;
constraint costetotal=sum(coste);
% var int:costetotal=sum(coste);
% solve minimize costetotal;
% solve minimize sum(coste);

% 9 minimizar el número de trayectos

% solve minimize posfin;

% 10 (Dificil) Ahora queremos entregar muchos paquetes entre varias ciudades (constante
% entregas). Diseñar un plan para hacer las entregas minimizando el coste total, y recordando
% que ahora en cada entrega van k paquetes (hay que multiplicar el coste por k). Se puede
% considerar que cada entrega se hace de forma independiente.

array [1..nentregas,1..max] of var 0..n:trayectos;
array [1..nentregas] of var 2..max:posfinales;
constraint forall(x in 1..nentregas)(trayectos[x,1]=entregas[x,1] /\ trayectos[x,posfinales[x]]=entregas[x,2]);
constraint forall(x in 1..nentregas)(forall(i in 1..max)
    (if i>posfinales[x] then trayectos[x,i]==FLAG else trayectos[x,i]!=FLAG endif)
  );
constraint forall(x in 1..nentregas)(
    forall(i,j in 1..posfin where i<j)(trayectos[x,i]!=trayectos[x,j])
  );
constraint forall(x in 1..nentregas)(
    forall(i in 2..posfin)(t[trayectos[x,i-1],trayectos[x,i]]!=0)
  );

array [1..nentregas,1..max-1] of var int:costes;

constraint forall(x in 1..nentregas)(
    forall(y in 1..max-1)(if y<posfin then costes[x,y]=(t[trayectos[x,y],trayectos[x,y+1]]*entregas[x,3]) else costes[x,y]=FLAG endif)
  );

solve minimize sum(costes);


% 9 minimizar el número de trayectos
%solve minimize sum(posfinales);


