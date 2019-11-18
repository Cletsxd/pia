%Estado meta
meta([1,2,3, 4,0,5, 6,7,8]).

%Mover el espacio vacio hacia la izquierda
s([A,0,B, C,D,E, F,G,H], [0,A,B, C,D,E, F,G,H],1). %primera fila
s([A,B,0, C,D,E, F,G,H], [A,0,B, C,D,E, F,G,H],1). %primera fila
s([A,B,C, D,0,E, F,G,H], [A,B,C, 0,D,E, F,G,H],1). %segunda fila
s([A,B,C, D,E,0, F,G,H], [A,B,C, D,0,E, F,G,H],1). %segunda fila
s([A,B,C, D,E,F, G,0,H], [A,B,C, D,E,F, 0,G,H],1). %tercera fila
s([A,B,C, D,E,F, G,H,0], [A,B,C, D,E,F, G,0,H],1). %tercera fila

%mover el espacio vacio hacia la derecha
s([A,0,B, C,D,E, F,G,H], [A,B,0, C,D,E, F,G,H],1). %primera fila
s([0,A,B, C,D,E, F,G,H], [A,0,B, C,D,E, F,G,H],1). %primera fila
s([A,B,C, D,0,E, F,G,H], [A,B,C, D,E,0, F,G,H],1). %segunda fila
s([A,B,C, 0,D,E, F,G,H], [A,B,C, D,0,E, F,G,H],1). %segunda fila
s([A,B,C, D,E,F, G,0,H], [A,B,C, D,E,F, G,H,0],1). %tercera fila
s([A,B,C, D,E,F, 0,G,H], [A,B,C, D,E,F, G,0,H],1). %tercera fila

%mover el espacio vacio hacia arriba
s([A,B,C, 0,D,E, F,G,H], [0,B,C, A,D,E, F,G,H],1). %desde segunda fila
s([A,B,C, D,0,E, F,G,H], [A,0,C, D,B,E, F,G,H],1). %desde segunda fila
s([A,B,C, D,E,0, F,G,H], [A,B,0, D,E,C, F,G,H],1). %desde segunda fila

s([A,B,C, D,E,F, 0,G,H], [A,B,C, 0,E,F, D,G,H],1). %desde tercera fila
s([A,B,C, D,E,F, G,0,H], [A,B,C, D,0,F, G,E,H],1). %desde tercera fila
s([A,B,C, D,E,F, G,H,0], [A,B,C, D,E,0, G,H,F],1). %desde tercera fila

%mover el espacio vacio hacia abajo
s([0,A,B, C,D,E, F,G,H], [C,A,B, 0,D,E, F,G,H],1). %desde la primera fila
s([A,0,B, C,D,E, F,G,H], [A,D,B, C,0,E, F,G,H],1). %desde la primera fila
s([A,B,0, C,D,E, F,G,H], [A,B,E, C,D,0, F,G,H],1). %desde la primera fila

s([A,B,C, 0,D,E, F,G,H], [A,B,C, F,D,E, 0,G,H],1). %desde la segunda fila
s([A,B,C, D,0,E, F,G,H], [A,B,C, D,G,E, F,0,H],1). %desde la segunda fila
s([A,B,C, D,E,0, F,G,H], [A,B,C, D,E,H, F,G,0],1). %desde la segunda fila

% h(Estado, Desorden): Desorden es el numero de fichas que no estan en
% su lugar, con respecto a la meta
h(Estado, Desorden):-
    K is 0,
    meta(Meta),!,
    heuristica(Estado,Meta, K, Desorden).

% heuristica([],[], Desorden, Desorden): caso base, cuando se revisaron
% todas las fichas, se devuelve el contador como Desorden.
heuristica([], [], Desorden, Desorden).

% heuristica([X|Ṕiezas], [Y|Meta], K, Desorden): compara la pieza X con
% la pieza Y en la misma posicion dentro del estado meta, si son
% iguales, se llama de nuevo a heuristica/4 con el contador K intacto.
heuristica([X|Piezas], [Y|Metas], K, Desorden):-
    X == Y,
    heuristica(Piezas, Metas, K, Desorden).

% heuristica([X|Piezas], [Y|Metas], K, Desorden): si las piezas X y Y
% son diferentes, aumentar el contador K a K1 y llamar a heuristica/4.
heuristica([X|Piezas], [Y|Metas], K, Desorden):-
    X =\= Y,
    K1 is K + 1,
    heuristica(Piezas, Metas, K1, Desorden).