int:N=6;
array [1..N,1..N] of var bool: t;

% a) Cada columna tenga exactamente un valor true
constraint forall(j in 1..N)(sum([t[i,j]|i in 1..N])==1);

% b) Las dos diagonales tengan una cantidad lo más parecida possible de trues
  
solve minimize abs((sum(i in 1..N)(t[i,i]))-(sum(i in 1..N)(t[i,N+1-i])));

output(
  [show(if (t[i,j]) then 1 else 0 endif)++
  (if (j==N) then "\n" else " " endif) | i in 1..N,j in 1..N]);