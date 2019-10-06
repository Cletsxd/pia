% subset/2. subset(ConjuntoA, ConjuntoB). ConjuntoA es subconjunto de ConjuntoB.
% Caso 1: base.
subset([], []).
% Caso 2: primer recursivo. Cuando el ConjuntoA es vacío [].
subset([], [_ | Rest]) :-
    subset([], Rest).
% Caso 3: recursivo general. Cuando el ConjuntoA y ConjuntoB tienen elementos.
subset([FirstElement | Rest], Set) :-
    member(FirstElement, Set), % Si FirstElement es miembro de Set.
    subset(Rest, Set). % Busca el resto Rest en el ConjuntoB Set.