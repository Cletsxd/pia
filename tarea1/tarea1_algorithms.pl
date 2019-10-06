%%% subset/2. subset(+ConjuntoA, +ConjuntoB).
% ConjuntoA es subconjunto de ConjuntoB.
% Caso 1: base.
subset([], []).
% Caso 2: recursivo. Cuando el ConjuntoA es vacío [].
subset([], [_ | Rest]) :-
    subset([], Rest).
% Caso 3: general. Cuando el ConjuntoA y ConjuntoB tienen elementos.
subset([Element | Rest], Set) :-
    member(Element, Set),
    subset(Rest, Set).

%%% inter/3. inter(+ConjuntoA, +ConjuntoB, -ConjuntoR). 
% El ConjuntoR es la intersección del ConjuntoA con el ConjuntoB.
% Caso 1: base.
inter([], _, []).
% Caso 2: recursivo. Cuando el Elemento no forma parte de Set.
inter([Element | Rest], Set, List) :-
    \+ member(Element, Set),
    inter(Rest, Set, List).
% Caso 3: recursivo. Cuando el Elemento se encuentra en Set.
inter([Element | Rest], Set, [Element | List]) :-
    member(Element, Set),
    inter(Rest, Set, List).

/*union([Element, Rest], SetB, SetR) :-
    member(Element, SetB).*/

%%% dif/3. dif(+ConjuntoA, +ConjuntoB, -ConjuntoR).
% ConjuntoR es la diferencia entre ConjuntoA y ConjuntoB.
% Caso 1: base.
dif([], _, []).
% Caso 2: recursivo. Cuando Element no está en ConjuntoB, se inserta en ConjuntoR.
dif([Element | Rest], SetB, [Element | List]):-
    \+ member(Element, SetB),
    dif(Rest, SetB, List).
% Caso 3: recursivo. Cuando Element está en ConjuntoB no se agrega a ConjuntoR.
dif([Element | Rest], SetB, List) :-
    member(Element, SetB),
    dif(Rest, SetB, List).