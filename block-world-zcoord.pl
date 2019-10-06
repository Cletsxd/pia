% z(B,Z): Returns the Z coordinate of block B

z(B,1) :- on(B,table).
z(B,Z) :-
    on(B,B1),
    z(B1,Z1),
    Z is Z1 + 1.

% coords(B,X,Y,Z): X,Y,Z are the coordinates of block B

coords(B,X,Y,Z) :-
    see(B,X,Y),
    z(B,Z).
