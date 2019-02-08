%“Se distribuyen 100 gavillas de trigo entre 100 personas, de
%forma que cada hombre recibe 3 gavillas, cada mujer 2 y cada
%niño media. Además, se sabe que hay 5 veces más mujeres que
%hombrese. ¿Cuántos hombres, mujeres y niños hay?


% constantes
int:gavillas=100;
int:personas=100;

int:h=3;
int:m=2;
float:n=0.5;

%variables

var int:nH;
var int:nM;
var int:nN;

%restricciones

constraint nH>=0 /\ nM>=0 /\ nN>=0;

constraint nH+nM+nN==personas;
constraint nH*h+nM*m+nN*n==gavillas;

constraint nM==5*nH;

solve satisfy;
