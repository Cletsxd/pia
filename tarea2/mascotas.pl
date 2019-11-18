goal([[], [], [perro, gato, hamster]]).
goal([[], [], [perro, hamster, gato]]).
goal([[], [], [gato, perro, hamster]]).
goal([[], [], [gato, hamster, perro]]).
goal([[], [], [hamster, perro, gato]]).
goal([[], [], [hamster, gato, perro]]).

s([[H | Old], [], New], [Old, [H], New]).
s([Old, [H], New], [Old, [], [H | New]]).
s([Old, [], [H | New]], [Old, [H], New]).
s([Old, [H], New], [[H | Old], [], New]).
s([[H | Old], [Car], New], [[Car | Old], [H], New]).
s([Old, [Car], [H | New]], [Old, [H], [Car | New]]).

secure(State) :-
    \+ (insecure(State)).

insecure([[perro, gato], _, _]).
insecure([[gato, perro], _, _]).
insecure([_, _, [perro, gato]]).
insecure([_, _, [gato, perro]]).
insecure([[hamster, gato], _, _]).
insecure([[gato, hamster], _, _]).
insecure([_, _, [hamster, gato]]).
insecure([_, _, [gato, hamster]]).

%%% solution/1. solution(+Node).
%%% No devuelve valor, busca la solucion a partir de Node que es el estado inicial.
solution(Node) :-
    first_depth([], Node, Sol),
    reverse(Sol, SolR),
    write_sol(SolR).

%%% first_depth/3. first_depth(+Way, +Node, -Sol).
%%% Se va trazando un camino Way a partir de un nodo padre Node (o raiz) y regresa la solucion.
%%% Busqueda primero en profundidad.
first_depth(Way, N, [N | Way]) :-
    goal(N).
first_depth(Way, Node, Sol) :-
    s(Node, N1),
    secure(N1),
    \+ (member(N1, Way)),
    first_depth([Node | Way], N1, Sol).

%%% write_sol/1. write_sol(+Sol).
%%% Escribe la solucion Sol.
write_sol([H | T]) :-
    \+ goal(H),
    get_head(H, H1),
    get_rest(H, T1),
    write("Move -> Old House: "), write(H1),
    get_head(T1, H2),
    get_rest(T1, T2),
    write(" Car: "), write(H2),
    get_head(T2, H3),
    write(" New House: "), write(H3), nl,
    write_sol(T).
write_sol([H | _]) :-
    goal(H),
    write("Goal: "), write(H).

%%% get_head/2. get_head(+List, -HeadList).
%%% Regresa la cabeza HeadList de la lista List
get_head([H | _], H).

%%% get_rest/2. get_rest(+List, -RestList).
%%% Regresa el resto Rest de la lista List.
get_rest([_ | T], T).