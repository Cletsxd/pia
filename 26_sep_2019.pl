% [26-septiembre-2019]
/*
%% suma(L, S): S es la suma de los elementos de L (una lista).
suma([], 0).
suma([X | Xs], L) :-
    L is X + Laux, % deja pendiente Laux
    suma(Xs, Laux). % Y los resuelve en esta línea

- Es posible definir versiones recursivar naif y a la cola:
    % naif
    reverso([], []).
    reverso([X | Xs], Res) :-
        reverso(Xs, XsReverso),
        append(XsReverso, [X], Res).

    % Recursivo a la cola
    reversoTr(L, Res) :-
        nonvar(L),
        reversoTRaux(L, [], Res).
    reversoTRaux([], Acc, Acc).
    reversoTRaux([X | Xs], Acc, Res) :-
        reversoTRaux(Xs, [X | Acc], Res).

    % Probar con time/1 para saber cuál es más demandante

- Operadores: notación prefija: +(*(2, a), *(b, c)).
- Podemos definir operadores de diferentes maneras:
    - Operadores infijos: xfx, xfy, yfx.
    - Operadores prefijos: fx, fy.
    - Operadores posfijos: xf, yf.
- Se asume que x tiene menor procedencia que y.
- Operadores proposicionales (podrían ser):
    op(N, O, F): N: presendencia, O: operador, F: función.
    op(800, xfx, equiv).
    op(700, xfy, or).
    op(600, xfy, and).
    op(500, fy, not).

    Ej:
    ?- write_canonical(p and q or not r).

    % ¿Y la semántica?

- Ejemplo: deducción natural
    % semántica de los operadores
    or(X, Y) :- X; Y.
    and(X, Y) :- X, Y.
    not(X) :- \+ X.
    equiv(X, Y) :- (\+ X; Y), (\+Y; X).

    % premisas
    p.
    q.

    ?- not (p and q) equiv not p or not q.
    true

- Los términos comuestos funcionan como estructuras de datos.
- Por ejemplo: el término punto(X, Y) representa un punto con sus coordenadas.
- El término seg(P1, P2) representa un segmento cuyos extremos son los puntos P1 y P2.
- horizontal/2, vertical/2 slide 35 pia_03.pdf.
- = verifica unificación, \= verifica la no unificación.
- Prolog no tiene chequeo de ocurrencias, por eso la última meta produce un ciclo infinito (**).
- El operador =.. convierte predicados en listas.
- Prolog tiene definidos predicados para saber el tipo de una fbf: atomic, var, nonvar, etc., (ver manual).
* Bajar manual de correo.
    ?- papa(X, juan) =.. L.
    ?- 2 + 3 =.. [Op | Args].
    ? R =.. [+, 2, 3].

- Operadores aritméticos [slide 40, pia_03.pdf].
- No confundir el operador is con la asignación convencional.
- El operador = unifica sus argumentos, pero no los evalúa.
- Es posible usar operadores en las reglas.
- Observar* que se pierde generalidad.
- ¡PELAAASSSSS!
- Operadores de comparación [slide 42, pia_03.pdf]
- Factorial:
    factTR(X, F) :-
        fact(X, 1, F).
    fact(0, Acc, Acc).
    fact(N, Acc, R) :-
        N > 0,
        N1 is N - 1,
        Acc1 is Acc * N,
        fact(N1, Acc1, R).

- Constraint Logic Programming
- Algunas funciones no pueden ser optimizadas:
    - suma/2 sin recursivo a la cola
    - long/2 " " " " " "
- Generar una lista creciente cuyo primer valor es X y el último valor es Y. [slide 47, pia_03.pdf].
- intervalo/3.
    ?- intervalo(1, 5, R).
    R = [1, 2, 3, 4, 5]
    Yes.
    ?- intervalo(3, 1, R).
    false.

- pares/2 filtra los elementos en su primer argumento. [slide 48, pia_03.pdf].
- Se puede combinar con intervalo/3 en una meta compuesta.
    ?- intervalo(1, 5, Aux), pares(Aux, Resp).
    Aux = [1, 2, 3, 4, 5].
    Resp = [2, 4].

- Lista ordenada, el predicado ordenada/1 es verdadero si su argumento es una lista ordenada.
    ?- ordenada([1, 2, 3]).
    true.
    ?- ordenada([1, 3, 2]).
    false.

- Inserción en una lista ordenada:
    - inserta/3 pone el primer elemento en la lista ordenada segundo argumento, en el lugar correspondiente. [slide 51, pia_03.pdf].
- Método por inserción (ordenamiento) (no a la cola).
- Método por burbuja.
- Método QuickSort [slide 54 pia_03.pdf].
*/