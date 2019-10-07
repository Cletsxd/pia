/* [03-octubre-2019]

- Búsquedas.
- Representación de conocimiento.
    - Base de conocimiento: lo necesario saber a cerca del problema que se está resolviendo.
- Búsqueda en profundidad [slide 4 pia_04.pdf].
- Estados y acciones.
    - ¿Cómo podemos definir un problema y sus soluciones de manera declarativa?
    - Estados y acciones configuran un grafo dirigido conocido como espacio de estados de un problema.
    - La solución a un problema dado consiste en encontrar un camino desde un nodo representado el estado inicial,
    hasta el estado final deseado.
    - Cada paso en este camino está dado por una acción válida.
    - La representación de los estados debe ser compacta y favorecer el cómputo eficiente de los sucesores.
    -
    * Ejercicio: trace de s/2 [slide 11 pia_04.pdf]
        [trace]  ?- s([[a], [b], [c]], Succ).
            Call: (8) s([[a], [b], [c]], _4482) ? creep
            Call: (9) quitar([_4736|_4724], [[a], [b], [c]], _4766) ? creep
            Exit: (9) quitar([a], [[a], [b], [c]], [[b], [c]]) ? creep
            Call: (9) quitar(_4738, [[b], [c]], _4732) ? creep
            Exit: (9) quitar([b], [[b], [c]], [[c]]) ? creep
            Exit: (8) s([[a], [b], [c]], [[], [a, b], [c]]) ? creep
        Succ = [[], [a, b], [c]] ;
            Redo: (9) quitar(_4738, [[b], [c]], _4732) ? creep
            Call: (10) quitar(_4738, [[c]], _4750) ? creep
            Exit: (10) quitar([c], [[c]], []) ? creep
            Exit: (9) quitar([c], [[b], [c]], [[b]]) ? creep
            Exit: (8) s([[a], [b], [c]], [[], [a, c], [b]]) ? creep
        Succ = [[], [a, c], [b]] ;
            Redo: (10) quitar(_4738, [[c]], _4750) ? creep
            Call: (11) quitar(_4738, [], _4756) ? creep
            Fail: (11) quitar(_4738, [], _4756) ? creep
            Fail: (10) quitar(_4738, [[c]], _4750) ? creep
            Fail: (9) quitar(_4738, [[b], [c]], _4732) ? creep
            Redo: (9) quitar([_4736|_4724], [[a], [b], [c]], _4766) ? creep
            Call: (10) quitar([_4736|_4724], [[b], [c]], _4750) ? creep
            Exit: (10) quitar([b], [[b], [c]], [[c]]) ? creep
            Exit: (9) quitar([b], [[a], [b], [c]], [[a], [c]]) ? creep
            Call: (9) quitar(_4738, [[a], [c]], _4732) ? creep
            Exit: (9) quitar([a], [[a], [c]], [[c]]) ? creep
            Exit: (8) s([[a], [b], [c]], [[], [b, a], [c]]) ? creep
        Succ = [[], [b, a], [c]] ;
            Redo: (9) quitar(_4738, [[a], [c]], _4732) ? creep
            Call: (10) quitar(_4738, [[c]], _4756) ? creep
            Exit: (10) quitar([c], [[c]], []) ? creep
            Exit: (9) quitar([c], [[a], [c]], [[a]]) ? creep
            Exit: (8) s([[a], [b], [c]], [[], [b, c], [a]]) ? creep
        Succ = [[], [b, c], [a]] ;
            Redo: (10) quitar(_4738, [[c]], _4756) ? creep
            Call: (11) quitar(_4738, [], _4762) ? creep
            Fail: (11) quitar(_4738, [], _4762) ? creep
            Fail: (10) quitar(_4738, [[c]], _4756) ? creep
            Fail: (9) quitar(_4738, [[a], [c]], _4732) ? creep
            Redo: (10) quitar([_4736|_4724], [[b], [c]], _4750) ? creep
            Call: (11) quitar([_4736|_4724], [[c]], _4756) ? creep
            Exit: (11) quitar([c], [[c]], []) ? creep
            Exit: (10) quitar([c], [[b], [c]], [[b]]) ? creep
            Exit: (9) quitar([c], [[a], [b], [c]], [[a], [b]]) ? creep
            Call: (9) quitar(_4738, [[a], [b]], _4732) ? creep
            Exit: (9) quitar([a], [[a], [b]], [[b]]) ? creep
            Exit: (8) s([[a], [b], [c]], [[], [c, a], [b]]) ? creep
        Succ = [[], [c, a], [b]] ;
            Redo: (9) quitar(_4738, [[a], [b]], _4732) ? creep
            Call: (10) quitar(_4738, [[b]], _4762) ? creep
            Exit: (10) quitar([b], [[b]], []) ? creep
            Exit: (9) quitar([b], [[a], [b]], [[a]]) ? creep
            Exit: (8) s([[a], [b], [c]], [[], [c, b], [a]]) ? creep
        Succ = [[], [c, b], [a]] ;
            Redo: (10) quitar(_4738, [[b]], _4762) ? creep
            Call: (11) quitar(_4738, [], _4768) ? creep
            Fail: (11) quitar(_4738, [], _4768) ? creep
            Fail: (10) quitar(_4738, [[b]], _4762) ? creep
            Fail: (9) quitar(_4738, [[a], [b]], _4732) ? creep
            Redo: (11) quitar([_4736|_4724], [[c]], _4756) ? creep
            Call: (12) quitar([_4736|_4724], [], _4762) ? creep
            Fail: (12) quitar([_4736|_4724], [], _4762) ? creep
            Fail: (11) quitar([_4736|_4724], [[c]], _4756) ? creep
            Fail: (10) quitar([_4736|_4724], [[b], [c]], _4750) ? creep
            Fail: (9) quitar([_4736|_4724], [[a], [b], [c]], _4766) ? creep
            Fail: (8) s([[a], [b], [c]], _4482) ? creep
        false.
    - Una meta se puede caracterizar en términos de propiedades esperadas de los estados.
* Investigar qué hace bagof, findall.
http://www.github.com/triska/the-power-of-prolog
*/

s(Pilas, [Pila1, [Tope1 | Pila2] | OtrasPilas]) :-
    quitar([Tope1 | Pila1], Pilas, Pilas1),
    quitar(Pila2, Pilas1, OtrasPilas).
quitar(X, [X | Ys], Ys).
quitar(X, [Y | Ys], [Y | Ys1]) :-
    quitar(X, Ys, Ys1).