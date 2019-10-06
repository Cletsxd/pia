% subset/2. subset(+ConjuntoA, +ConjuntoB). ConjuntoA es subconjunto de ConjuntoB.
% Caso 1: base.
subset([], []).
% Caso 2: recursivo. Cuando el ConjuntoA es vacío [].
subset([], [_ | Rest]) :-
    subset([], Rest).
% Caso 3: general. Cuando el ConjuntoA y ConjuntoB tienen elementos.
subset([Element | Rest], Set) :-
    member(Element, Set), % Si FirstElement es miembro de Set.
    subset(Rest, Set). % Busca el resto Rest en el ConjuntoB Set.

% inter/3. inter(+ConjuntoA, +ConjuntoB, -ConjuntoS). El ConjuntoS es la intersección del
    % ConjuntoA con el ConjuntoB.
% Caso base.
inter([], _, []).
% Caso 2: recursivo. Cuando el Elemento no forma parte de Set.
inter([Element | Rest], Set, List) :-
    not(member(Element, Set)),
    inter(Rest, Set, List).
% Caso 3: recursivo. Cuando el Elemento se encuentra en Set.
inter([Element | Rest], Set, [Element | List]) :-
    member(Element, Set),
    inter(Rest, Set, List).