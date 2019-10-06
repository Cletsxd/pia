%%% loc_en(X,Y)/2
%%% La ciudad X está localizada en el estado Y

loc_en(atlanta,georgia).
loc_en(houston,texas).
loc_en(austin,texas).
loc_en(boston,massachussets).
loc_en(xalapa,veracruz).
loc_en(veracruz,veracruz).

%%% loc_en(X,Y)/2
%%% La ciudad X está localizada en el país Y

loc_en(X,usa) :- loc_en(X,georgia).
loc_en(X,usa) :- loc_en(X,texas).
loc_en(X,usa) :- loc_en(X,massachussets).

loc_en(X,mexico) :- loc_en(X,veracruz).

%%% loc_en(X,Y)/2
%%% La ciudad X está en norteamérica

loc_en(X,norteamerica) :- loc_en(X,usa).
loc_en(X,norteamerica) :- loc_en(X,usa).
loc_en(X,norteamerica) :- loc_en(X,mexico).

%%% gringas/1
%%% Las ciudades en la lista X son todas gringas

gringas([X]) :- loc_en(X,usa).
gringas([X|Xs]) :- loc_en(X,usa), gringas(Xs).

%%% miembro(X,Ys)
%%% El elemento X es miembro de la lista Ys

miembro(X,[X|_]).
miembro(X,[_|Ys]) :- miembro(X,Ys).

%%% long(Xs,L)
%%% L es la longitud de la lista Xs

long([],0).
long([_|Xs],L) :- long(Xs,L1), L is L1+1.

%%% longTR(Xs,L)

longTR(Xs,L) :- long(Xs,0,L).

long([],Acc,Acc).
long([_|Xs],Acc,L) :- Acc1 is Acc + 1, long(Xs,Acc1,L).

%%% creaLista(N,L)
%%% crea una lista L de N elementos (para descreídos)

creaLista(0,[]).
creaLista(N,[N|Ns]) :- N1 is N-1, creaLista(N1,Ns).

%%% append(X,Y,Z)
%%% regresa los elementos de X agregados a Y en la lista Z

append([],Ys,Ys).
append([X|Xs], Ys, [X|Zs]) :-  append(Xs,Ys,Zs).

%%% Partes de una lista

prefijo(Xs,Ys) :- append(Xs,_,Ys).
sufijo(Xs,Ys) :- append(_,Xs,Ys).
sublista(Xs,Ys):- prefijo(Aux,Ys), sufijo(Xs,Aux).

%%% Agregando y eliminando elementos de una lista

% add(X,L,R): R es la lista que resulta de agregar X a L
add(X,L,[X|L]).

% del(X,L,R): R es la lista que resulta de eliminar X de L
del(X,[X|Cola],Cola).
del(X,[Y|Cola],[Y|Cola1]) :-
    del(X,Cola,Cola1).

%%% Reverso y ReversoTR

reverso([],[]).
reverso([X|Xs],Res) :-
	reverso(Xs,XsReverso),
	append(XsReverso,[X],Res).

reversoTR(L,Res):-
	nonvar(L),
	reversoTRaux(L,[],Res).
reversoTRaux([],Acc,Acc).
reversoTRaux([X|Xs],Acc,Res) :- reversoTRaux(Xs,[X|Acc],Res).

