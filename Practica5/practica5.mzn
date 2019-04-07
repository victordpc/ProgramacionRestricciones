% Use this editor as a MiniZinc scratch book
include "alldifferent.mzn";

int:N=5;

%array [1..N,1..N] of var 1..N: t=[| _,_,_,_,_ |
%                                    4,_,_,_,2 |
%                                    _,_,4,_,_ |
%                                    _,_,_,_,4 |
%                                    _,_,_,_,_ |];

%array [1..N,1..N-1] of 0..2: r=[|1,0,1,1
%                                |0,0,0,0
%                                |0,0,0,0
%                                |0,0,0,2
%                                |2,2,0,0|];

%constraint forall(i in 1..N)(forall(j,k in 1..N where j<k)(t[i,j]!=t[i,k]));
%constraint forall (i in 1..N)(alldifferent( [t[j,i] | j in 1..N]  ));

%constraint forall(i in 1..N)(forall(j in 1..N-1)(
%    if r[i,j]==1 then t[i,j]>t[i,j+1] else 
%    ( if r[i,j]==2 then t[i,j]<t[i,j+1] endif ) 
%    endif
%));

%output["_________________________\n"];
%output(
%  [(if (j==1) then "|" else " " endif) ++
%  show(t[i,j]) ++
%  (if (rf[i,j]==1) then " >" else (if (rf[i,j]==2) then " <" else "  " endif) endif)++
%  (if (j==N) then "|\n" else " " endif) | i in 1..N,j in 1..N]);
%output["_________________________\n"];




array [1..N,1..N] of var 1..N: t=[| _,_,_,_,_ |
                                    _,_,_,_,_ |
                                    _,_,4,_,_ |
                                    _,_,_,_,_ |
                                    _,_,_,_,4 |];

array [1..N,1..N-1] of 0..2: rf=[|0,0,0,0
                                 |0,1,2,0
                                 |0,0,0,1
                                 |0,0,0,0
                                 |1,0,2,0|];


array [1..N-1,1..N] of 0..2: rc=[|0,0,2,0,0
                                 |0,0,0,0,0
                                 |0,0,0,2,0
                                 |0,0,0,0,0|];


constraint forall(i in 1..N)(forall(j,k in 1..N where j<k)(t[i,j]!=t[i,k]));
constraint forall (i in 1..N)(alldifferent( [t[j,i] | j in 1..N] ));

constraint forall(i in 1..N)(forall(j in 1..N-1)(
    if rf[i,j]==1 then t[i,j]>t[i,j+1] else 
    ( if rf[i,j]==2 then t[i,j]<t[i,j+1] endif ) 
    endif
));

constraint forall(j in 1..N)(forall(i in 1..N-1)(
    if rc[i,j]==1 then t[i,j]>t[i+1,j] else 
    ( if rc[i,j]==2 then t[i,j]<t[i+1,j] endif ) 
    endif
));



output["_________________________\n"];

output(
  [(if (j==1) then "|" else " " endif) ++
  
  if((i mod 2)==1) then
    (show(t[(i div 2)+1,j]) ++
    (if (rf[(i div 2)+1,j]==1) then " >" else 
      (if (rf[(i div 2)+1,j]==2) then " <" else "  " endif)   
    endif))
  else
    (if (rc[(i div 2),j]==1) then "v" else 
      (if (rc[(i div 2),j]==2) then "^" else " " endif) 
    endif) ++ "  " 
  endif
  
  ++ (if (j==N) then "|\n" else " " endif) | i in 1..2*N,j in 1..N]);



%output(
%  [(if (j==1) then "|" else " " endif) ++
%  show(t[i,j]) ++
%  (if (rf[i,j]==1) then " >" else (if (rf[i,j]==2) then " <" else "  " endif) endif)++
%  (if (j==N) then "|\n" else " " endif) | i in 1..N,j in 1..N]);
output["_________________________\n"];


