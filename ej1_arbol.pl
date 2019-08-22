% progenitor/2. progenitor(X, Y), X es progenitor de Y.
progenitor(pam, bob).
progenitor(tom, bob).
progenitor(tom, liz).
progenitor(bob, ann).
progenitor(bob, pat).
progenitor(pat, jim).

% mujer/1 y hombre/1. mujer(X), es mujer. hombre(X), X es hombre.
hombre(bob).
hombre(tom).
hombre(jim).
mujer(pam).
mujer(pat).
mujer(ann).
mujer(liz).

% vastago/2. vastago(Y, X), Y es un vástago de X.
% Regla: si X es un progenitor de Y entonces, Y es un vástago de X.
vastago(Y, X) :-
    progenitor(X, Y).

% mujer/2. mujer(X, Y), X es madre de Y.
% Regla: si X es mujer, y X es progenitor de Y entonces, X es madre de Y.
madre(X, Y) :-
    progenitor(X, Y),
    mujer(X).

% abuela/2. abuela(X, Y), X es abuela de Y.
% Regla: si X es mujer, X es progenitor de Z, y Z de progenitor de Y entonces, X es abuela de Y. 
abuela(X, Y) :-
    progenitor(X, Z),
    progenitor(Z, Y),
    mujer(X).

% hermana/2. hermana(X, Y), X es hermana de Y.
% Regla: si X es mujer, Z es progenitor de X, y Z progenitor de Y entonces, X es hermana de Y.
hermana(X, Y) :-
    progenitor(Z, X),
    progenitor(Z, Y),
    mujer(X),
    dif(X, Y).

% ancestro/2. ancestro(X, Z), X es ancestro de Z.
% Regla: si X es progenitor de Z entonces, X es ancestro de Z.
ancestro(X, Z) :-
    progenitor(X, Z).

% ancestro/2 recursiva. ancestro(X, Z), X es ancestro de Z.
% Regla: si X es progenitor de Y, Y es progenitor de Z
ancestro(X, Z) :-
    progenitor(X, Y),
    ancestro(Y, Z).