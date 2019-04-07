% Use this editor as a MiniZinc scratch book
include "alldifferent.mzn";

int:N=9;
array [1..N,1..N] of var 1..N: s=[| 8,_,_,_,_,_,_,_,_, |
                                    _,_,3,6,_,_,_,_,_, |
                                    _,7,_,_,9,_,2,_,_, |
                                    _,5,_,_,_,7,_,_,_, |
                                    _,_,_,_,4,5,7,_,_, |
                                    _,_,_,1,_,_,_,3,_, |
                                    _,_,1,_,_,_,_,6,8, |
                                    _,_,8,5,_,_,_,1,_, |
                                    _,9,_,_,_,_,4,_,_, |];
                                    

constraint forall(i,j in 0..2)
  (alldifferent([s[l,m] | l,m in 1..9 where (l-1) div 3 == i /\ (m-1) div 3 == j ]));


constraint forall (i in 1..N)(alldifferent( [s[i,j] | j in 1..N] ));
constraint forall (j in 1..N)(alldifferent( [s[i,j] | i in 1..N] ));

% Diagonales unicas
%constraint alldifferent([s[i,i] | i in 1..N]);
%constraint alldifferent([s[i,N+1-i] | i in 1..N]);

output["_________________________\n"];
output(
  [show(s[i,j]) ++
  (if (j==N) then " \n" else if (j mod 3 == 0) then "|" else " " endif endif) | i in 1..N,j in 1..N]);
output["_________________________\n"];

