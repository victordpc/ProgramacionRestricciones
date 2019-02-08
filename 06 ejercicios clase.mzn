%var bool:a;
%var bool:b;

% constraint a<->b; % <-> significa si solo si



%var -10..10:a;
%var int:b;

%constraint a==4 -> b==5; % -> significa entonces
%constraint a!=4 -> (b>=0 /\ b <=3 /\ a>b /\a<b+2);


%var -10..10:a;
%var -10..10:b;

%constraint a=b*b*b /\ a*a>0;

%var -10..10:a;
%var bool:b;
%%b vale 1 si a es par y b vale 0 si a es impar
%constraint (a mod 2==0)-> b=1;
%constraint (a mod 2==1)-> b=0;

%var -10..10:a;
%var -10..10:b;

%constraint a==0;
%constraint a==1;

%solve satisfy;

%%%%%%%% fundición
float: dias;
float: cant_h;
float: cant_c;
float: precio_a;
float: precio_b;

% cantidades a fabricar de cada producto
var float: a;
var float: b;

% límite de tiempo de uso de horno
constraint  a*3.0+b*4.0<=dias;
% no se puede superar la cant. de hierro almacenado
constraint 14.0*a+2.1*b<=cant_h;
% ni la de carbón
constraint 2.0*a+11.0*b<=cant_c;
% cantidades no negativas
constraint a>=0.0;
constraint b>=0.0;

% maximizar el beneficio
solve maximize precio_a*a+precio_b*b;

%mostrar el resultado
output ["A=", show(a), "\t B=", show(b),  "\tganancia:", show(18.5*a+20.7*b),
           "\nSobra carbón: ", show(cant_c-(2.0*a+11.0*b)), "\tSobra hierro: ", show(cant_h-(14.0*a+2.1*b)),
          "\n Sobran días de horno:", show(dias-(a*3.0+b*4.0)),"\n"];
