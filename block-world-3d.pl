%% see(Block,X,Y)
% Block is observed by the camera at coordinates X,Y

see(a,2,3).
see(d,4,4).
see(e,4,2).

%% on(Block,Object)
% Block is standing on Object

on(a,b).
on(b,c).
on(c,table).
on(d,table).
on(e,table).

%% Tests

% ?- on(B,_).
%@ B = a ;
%@ B = b ;
%@ B = c ;
%@ B = d ;
%@ B = e. 

