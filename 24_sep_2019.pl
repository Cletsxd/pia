/* [24-septiembre-2019]
Una lista se define de manera recursiva:
    - Una lista vacía se denota como [].
    - Una lista no vacía se denota como [X|Xs], donde X se conoce como una cabeza de la lista Xs como cola de la lista, que es a su vez una lista.
    - Unificación
        ?- [1, 2, 3] = [1 | [2 | [3 | []]]].
        Yes.
    - SWI-Prolog no una el punto como fuctor para denotar listas.
    - Toda lista tiene una cabeza y una cola.
        ?- [X | Xs] = [1, 2, 3]
        X = 1
        Xs = [2, 3] ;
        No.
    - Todas las ciudades de la lista son gringas:
        % gringas(+L): todas ciudades en la lista L son gringas
        gringas([X]) :- loc_en(X, usa).
        gringas([X | Xs]) :- loc_en(X, usa), gringas(Xs).

        ?- gringas([boston]).
        true.
        ?- gringas([]).
        false.
        ?- gringas([boston, houston, xalapa]).
        false.
        ?- gringas(L).
        L = [atlanta] ;
        L = [houston] ;
        L = [austin] ;
        L = [boston] ;
        L = [atlanta, atlanta] ;
        L = [atlanta, houston]

        % miembro(X, L): el elemento X es miembro de la lista L.
        miembro(X, [X | _]).
        miembro(X, [_ | Xs]) :- miembro(X, Xs).

        ?- miembro(1, []).
        false.
        ?- miembro(1, [1]).
        true.
        ?- miembro(1, [3, 2, 1]).
        true.
        ?- miembro(X, [1, 2]).
        X = 1 ;
        X = 2 ;
        false.
        ?- miembro(1, L). % slide 18 pia_03.pl
    - Se pueden computar permutaciones:
        ?- L = [_, _, _], miembro(a, L), miembro(b, L), miembro(c, L).
        L = [a, b, c] ;
        L = [a, c, b] ;
        L = [b, a, c] ;
        L = [c, a, b] ;
        L = [b, c, a] ;
        L = [c, b, a] ;
        false.
    - Longitud de lista:
        % long(L, S): S es la longitud de la lista L
        long([], 0).
        long([_ | Xs], L) :-
            long(Xs, L1),
            L is L1 + 1.

        ?- long([1, 2, 3, 4], L).
        L = 4 ;
        false.
        ?- long([], L).
        L = 0 ;
        false.

    - Traza de programas. [slide 21 pia_03.pl]
        - Call: un evento de llamada ocurre cuendo Prolog comienza a satisfacer una meta.
        - Exit: un evento de salida ocurre cuando alguna meta es satisfecha.
        - Redo...
        - Fail...

    - Algunos tipos de recursividad son ineficientes, ej. "recursivo NO a la cola" long/2.
    - "Recursivo a la cola":
        % longTR(Xs, L): recibe una lista Xs y devuelve la longitud en L.
        longTR(Xs, L) :- long(Xs, 0, L).
        long([], Acc, Acc).
        long([_ | Xs], Acc, L) :-
            Acc1 is Acc + 1,
            long(Xs, Acc1, L).

        ?- longTR([1, 2, 3, 4], L).
        L = 4 ;
        false.
        ?- longTR([], L).
        L = 0 ;
        false.

    - A la cola O(1) vs no a la cola O(n).
    - mist/2 slide 26 pia_03.pdf (crearLista/2).
    - time/1 slide 27 pia_03.pdf.
    - Agregando dos listas:
        % append(L1, L2, L3): la lista L3 es el resultado de agregar L1 a L2.
        append([], Ys, Ys).
        append([X | Xs], Ys, [X | Zs]) :- append(Xs, Ys, Zs).s

        ?- append([1, 2, 3], [4, 5, 6], L).
        L = [1, 2, 3, 4, 5, 6].
    - Agregar un elemento a una lista: slide 29
    - Eliminar X de L: slide 29
    - Partes de una lista:
        - prefijo/2: "lo que está antes".
        - sufijo/2: "lo que está después".
        - sublista/2: "que una lista está dentro de otra".
*/