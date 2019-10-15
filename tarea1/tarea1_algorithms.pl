%%% unify/4. unify(+Term1, +Term2, -Unifiable, -Substitution).
% Sean Term1 y Term2, dos términos.
% Caso 1: base. Cuando (Term1 es variable o Term2 es variable) y son iguales.
% Salida: Unifiable = 1, Substitution = [].
unify(Term1, Term2, 1, []) :-
    are_variables(Term1, Term2),
    wts_variable(Term1, Term2, X, T),
    X == T.

% Caso 2: base. Cuando (Term1 es variable o Term2 es variable), pero no son iguales y (X ocurre en T).
% Salida: Unifiable = 0.
unify(Term1, Term2, 0, _) :-
    are_variables(Term1, Term2),
    wts_variable(Term1, Term2, X, T),
    ocurr(X, T).

% Caso 3: base. Cuando (Term1 es variable o Term2 es variable), no son iguales y (X no ocurre en T).
% Salida: Unifiable = 1, Substitution = X/T.
unify(Term1, Term2, 1, [X/T]) :-
    are_variables(Term1, Term2),
    wts_variable(Term1, Term2, X, T).

% Caso 4: base. Cuando (Term 1 o Term2 no es variable), ambos son functores o átomos.
% Los nombres deben ser diferentes y la aridad de ambos deben ser también diferentes.
% Salida: Unifiable = 0.
unify(Term1, Term2, 0, _) :-
    \+ are_variables(Term1, Term2),
    functor(Term1, F, X),
    functor(Term2, G, M),
    F \= G, !;
    X \= M.

% Caso 5: recursivo. Cuando Term1 y Term2 son functores y traen consigo variables o átomos (argumentos).
% Salida: Unifiable = 1, Substitution = [lista de sustituciones].
unify(Term1, Term2, Unifiable, Substitution) :-
    \+ are_variables(Term1, Term2),
    K is 0,
    functor(Term1, _, X),
    functor(Term2, _, M),
    % Basado en:
        % https://www.swi-prolog.org/pldoc/doc/_SWI_/library/occurs.pl?show=src
        % https://www.swi-prolog.org/pldoc/doc_for?object=arg/3
        % https://www.swi-prolog.org/pldoc/doc_for?object=compound/1
    findall(Args, arg(_, Term1, Args), ArgsT1),
    findall(Args, arg(_, Term2, Args), ArgsT2),
    check_unify_loop(ArgsT1, ArgsT2, K, X, M, Unifiable, Substitution).

% check_unify_loop/7. check_unify_loop(+ArgsT1, +ArgsT2, +K, +X, +M, -Unifiable, -Substution).
% ArgsT1 y Args2: los argumentos de los functores Term1 y Term2.
% K: contador, el cual ayuda a recorrer los argumentos respecto a la aridad del Term2 (M).
% X: aridad de Term1.
% M: aridad de Term2.
% Salida: Unifiable = 1, Substitution = [lista de sustituciones].
% Caso 1: base. Cuando el contador K llega al valor de la aridad M, se rompe el ciclo.
check_unify_loop(_, _, K, _, M, _, []) :-
    K == M.
% Caso 2: recursivo. Recorre las listas de los argumentos de Term1 y Term2. Y checa unificación.
check_unify_loop([AT1 | RestArgsT1], [AT2 | RestArgsT2], K, X, M, U, [S | RestS]) :-
    K < M,
    unify(AT1, AT2, U, S),
    K1 is K + 1,
    check_unify_loop(RestArgsT1, RestArgsT2, K1, X, M, U, RestS),
    U == 1.

% ocurr/2. ocurr(+X, +Term).
% X ocurre en Term.
% Caso 1: principal. Revisa si hay alguna ocurrencia de X en Term.
ocurr(X, T) :-
    term_variables(T, Vars),
    verif(X, Vars).

% verif/2. verif(+X, +List).
% Revisa los elementos de List y compara contra X. Si X == H, devuelve true.
% Caso 1: base. Cuando List es vacía.
verif(_, []).
% Caso 2: recursivo. Si List no es vacía, sigue recorriendo hasta encontrar el valor de X, o
% en su defecto, encontrar una lista vacía en List.
verif(X, [H | T]) :-
    X == H,
    verif(X, T).

% are_variables/2. are_variables(+Term1, +Term2).
% Pregunta si Term1 o Term2 son variables.
% Caso 1: principal.
are_variables(T1, T2) :-
    var(T1), !;
    var(T2).

% wts_variable/4. wts_variable(+Term1, +Term2, -X, -T).
% Si Term1 es una variable, Term2 es un término (puede ser átomo o fuctor).
% Caso 1: base principal.
wts_variable(T1, T2, T1, T2) :-
    var(T1).
% Caso 2: secundario. Si Term1 no es una variable, X = Term2 y T = Term1.
wts_variable(T1, T2, T2, T1) :-
    \+ var(T1),
    var(T2).

%%% peanoToNat/2. peanoToNat(+Secuencia, -N).
% Basado en is_nat/2.
% N es el número de Peano dada una Secuencia. Ej. peanoNat(s(s(s(0))), N).
% Caso 1: base. Cuando la Secuencia llega a 0, entonces N unifica con 0.
peanoToNat(0, 0).
% Caso 2: recursivo. Función que se dedica a sumar los sucesores y a reducir la Secuencia hasta 0.
peanoToNat(s(X), N) :-
    peanoToNat(X, N1),
    N is N1 + 1.

%%% is_nat/2. is_nat(+NumInSec, -N).
% Si NumInSec (número en la Secuencia) es un número natural, N es número de Peano.
% Basado en:
    % 1. http://www.lcc.uma.es/~lopez/progdec/prolog/apuntes/02-basicas/tecnicas_basicas.pdf (páginas 1 - 7)
    % 2. https://www.uv.mx/personal/aguerra/files/2019/08/pia-slides-02.pdf (slide 45)
    % 3. http://enciclopedia.us.es/index.php/Axiomas_de_Peano
% N es el número de Peano, el cual se computa dentro de esta función.
% Cuando la función unifica a 0 con NumInSec (Caso 1),
    % N también unifica con 0 (desde Caso 2).
% Caso 1: base.
is_nat(0, 0).
% Caso 2: recursivo.
is_nat(s(X), N) :-
    is_nat(X, N1),
    N is N1 + 1.

/*sumaPeano_PersonalVersion(Sec1, Sec2, R) :-
    is_nat(Sec1, NumSec1),
    is_nat(Sec2, NumSec2),
    R is NumSec1 + NumSec2.*/

%%% sumaPeano/3. sumaPeano(+Secuencia1, +Secuencia2, -Resultado).
% Resultado es la suma de Peano de Secuencia1 y Secuencia2.
% Caso 1: base. Cuando la Sencuencia2 llega a 0, se termina el ciclo recursivo causado por Caso 2 y 3.
sumaPeano(s(0), 0, s(0)).
% Caso 2: recursivo. Si la Secuencia1 llega a s(0), comienza a agregar la Secuencia2 a Resultado.
    % Secuencia1 solo llega a s(0) simplemente para que no se agregue un 0 y eso haga terminar el ciclo.
sumaPeano(s(0), s(X2), s(R)) :-
    sumaPeano(s(0), X2, R).
% Caso 3: recursivo. Cuando las dos secuencias contienen términos en sí mismas.
sumaPeano(s(X1), Sec2, s(R)) :-
    sumaPeano(X1, Sec2, R).

%%% restaPeano/3. restaPeano(+Secuencia1, +Secuencia2, -Resultado).
% Resultado es la resta de Peano de Secuencia1 menos Sencuencia2.
% Caso 1: base. Esta cláusula entra en función cuando ambas secuencias llegan a s(0), por lo tanto, se devuele un 0.
restaPeano(s(0), s(0), 0).
% Caso 2: recursivo. Esta función realiza la agregación de s(R), cuando Secuencia2 llega a s(0).
restaPeano(s(X1), s(0), s(R)) :-
    restaPeano(X1, s(0), R).
% Caso 3: recursivo. La idea de esta función es reducir ambas secuencias solo hasta que
    % la Sencuencia2 llegue a s(0), que es cuando entra en acción el Caso 2.
restaPeano(s(X1), s(X2), R) :-
    restaPeano(X1, X2, R).

%%% subset/2. subset(+ConjuntoA, +ConjuntoB).
% ConjuntoA es subconjunto de ConjuntoB.
% Caso 1: base.
subset([], []).
% Caso 2: recursivo. Cuando el ConjuntoA es vacío [].
subset([], [_ | Rest]) :-
    subset([], Rest).
% Caso 3: general. Cuando el ConjuntoA y ConjuntoB tienen elementos.
subset([Element | Rest], SetB) :-
    member(Element, SetB),
    subset(Rest, SetB).

%%% inter/3. inter(+ConjuntoA, +ConjuntoB, -ConjuntoR). 
% El ConjuntoR es la intersección del ConjuntoA con el ConjuntoB.
% Caso 1: base.
inter([], _, []).
% Caso 2: recursivo. Cuando el Elemento no forma parte de SetB.
inter([Element | Rest], SetB, List) :-
    \+ member(Element, SetB),
    inter(Rest, SetB, List).
% Caso 3: recursivo. Cuando el Elemento se encuentra en SetB.
inter([Element | Rest], SetB, [Element | List]) :-
    member(Element, SetB),
    inter(Rest, SetB, List).

%%% union/3. union(+ConjuntoA, +ConjuntoB, -ConjuntoR).
% El ConjuntoR es la unión del ConjuntoA con el ConjuntoB.
% Caso 1: base. Los conjuntos A y B no tienen elementos.
union([], [], []).
% Caso 2: recursivo. El ConjuntoA se quedó sin elementos, por lo tanto,
    % es momento de meter al ConjuntoR los elementos del ConjuntoB.
union([], [Element | Rest], [Element | List]) :-
    union([], Rest, List).
% Caso 3: recursivo. Primer caso que se ejecuto, debido a que el Caso 1 y 2, dan falso la primera vez.
    % Utilizado para insertar los elementos del ConjuntoA en el ConjuntoR.
    % Solamente si el elemento cabeza no pertenece al ConjuntoR, el elemento se inserta.
union([Element | Rest], Set2, [Element | List]) :-
    union(Rest, Set2, List),
    \+ member(Element, List).
% Caso 4: recursivo. Caso para control de inserción de elementos en ConjuntoR.
    % Si Element (elemento cabeza del ConjuntoA), pertenece a ConjuntoR, simplemente se unifica el ConjuntoR como venía.
    % Y no es necesario insertar Element.
union([Element | Rest], Set2, List) :-
    union(Rest, Set2, List),
    member(Element, List).

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

/*% basado en: 
    % - https://www.swi-prolog.org/pldoc/man?predicate=permutation/2
    % - https://www.swi-prolog.org/pldoc/man?predicate=select/3
    % - https://www.swi-prolog.org/pldoc/doc/_SWI_/library/lists.pl?show=src*/

%%% perms/2. perms(+List, -ListRes).
%%% List es una lista con valores en cierto orden que vana ser permutados.
%%% ListRes es una lista de listas con los valores de las permutaciones.
%%% Caso 1: principal. Esta función manda a llamar a findall/3, que a su vez llama a per/2, la cual realiza una permutación.
perms(List, ListRes) :-
    findall(Perm, per(List, Perm), ListRes).

%%% per/2. per(+List, -Perm).
%%% Recibe una lista de elementos y devuelve un resultado con la lista permutada.
%%% Caso 1: base. Cuando List sea vacío devuelve una lista vacía y se concatena en el siguiente caso.
per([], []).
%%% Caso 2: recursivo. Crea una permutación.
per(Perm, [Element | Rest]) :-
    value_in(Element, Perm, List),
    per(List, Rest).

%%% value_in/3. value_in(+Element, +Perm, -List)
%%% Caso 1: hace un intercambio que va acomodando los elementos, de manera que se crean varias combinaciones.
value_in(Element, [ElementP | RestP], List) :-
    create_permute(RestP, ElementP, Element, List).

%%% create_permute/3. create_permute(+RestP, +ElementP, +Element, -List).
%%% Caso 1: base. Crea una combinación.
create_permute(RestP, ElementP, ElementP, RestP).
create_permute([FirstElement | Rest], ElementP, Element, [ElementP | RestP]) :-
    create_permute(Rest, FirstElement, Element, RestP).