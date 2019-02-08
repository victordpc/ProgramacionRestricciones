var int:x;
var int:y;

constraint x>5;
constraint x<10;
constraint y<x;
constraint y>0;

%solve satisfy;
%solve minimize(y);
solve maximize(y+x);

