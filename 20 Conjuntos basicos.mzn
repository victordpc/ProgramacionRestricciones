% conjuntos
int:n=4;
int:rango=7;

%conjuntos
var set of 1..rango: s1;
var set of 1..rango: s2;

% Operaciones con conjuntos
constraint s1 intersect s2={4,5,7};
constraint card (s1 union s2)=4;

solve satisfy;

output ["s1: "++show(s1)++"\n", "s2: "++show(s2) ];
