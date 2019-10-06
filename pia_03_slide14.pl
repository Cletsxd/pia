% El mundo de los bloques

% see/3.
% see(Block, X, Y): Block is observed by the camera at coordinates X, Y.
see(a, 2, 3).
see(d, 4, 4).
see(e, 4, 2).

% on/2.
% on(Block, object): Block is standing on Object
on(a, b).
on(b, c).
on(c, table).
on(d, table).
on(e, table).

% z/2.
% z(B, Z): returnss the Z coordinate of block B
z(B, 1) :- on(B, table).
z(B, Z) :-
    on(B, B1),
    z(B1, Z1),
    Z is Z1 + 1.