%%% peanoNat/2. peanoNat(+Secuencia, -N).
% N es el número de Peano dada una Secuencia. Ej. peanoNat(s(s(s(0))), N).
peanoToNat(Sec, N) :-
    is_nat(Sec, N).

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

%%% is_nat/2. is_nat(+NumInSec, -N).
% Si NumInSec (número en la Secuencia) es un número natural, N es número de Peano.
% Basado en:
    % 1. http://www.lcc.uma.es/~lopez/progdec/prolog/apuntes/02-basicas/tecnicas_basicas.pdf (páginas 1 - 7)
    % 2. https://www.uv.mx/personal/aguerra/files/2019/08/pia-slides-02.pdf (slide 45)
    % 3. http://enciclopedia.us.es/index.php/Axiomas_de_Peano
% N es el número de Peano, el cual se computa dentro de esta función.
% Cuando la función unifica a 0 con NumInSec (Caso 1),
    % N también unifica con 0 (en Caso 2).
% Caso 1: base.
is_nat(0, 0).
% Caso 2: recursivo.
is_nat(s(X), N) :-
    is_nat(X, N1),
    N is N1 + 1.

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