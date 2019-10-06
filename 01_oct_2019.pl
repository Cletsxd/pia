/* [01-octubre-2019]

- Checar bibliotecas de Prolog (manual).
- Codificador slide 59 pia_03.pdf
* Ejercicio: Descompresor.
- Corrida subtérmino.
- Árboles binarios de búsqueda.
    - Insertar un elemento.
    - De lista a árbol.
    - Nodos de un árbol.
    - Ordena lista por inserción en árbol.
- Entradas y salidas en Prolog
    - Además de las metas, el usuario puede interactuar con Prolog usando flujos de entrada y salida.
    - El teclado y el monitor son los flujos por default.
    - write/1: escribe en pantalla un término.
    - nl/0: salto de línea.
    - tab/1: toma un argumento n, e inserta n espacios en blanco en el flujo de salida.
    - writeq/1 para desplegar las comillas dentro de una cadena.
    * ejercicio writelist/1.
    * ejercicio gráfica de barras bars/1.
    - read/1 provee la lectura de términos de un entrada. (unifica cosas) ***** (tal vez sirva para la tarea 1*****).
- ASCII
    - Para algunas aplicaciones es más conveniente bajar el nivel de las operacioens E/S a caracteres,
    usando código ACII para manipular cadenas.
    - UTF no está definido en el estándar Prolog.
    - Salida de caracterres put/1.
    - Entrada de caracteres get0/1 y get/1.
    - Contador de caracteres.
    - Contar vocales.
    - Archivos: tell/1 (cambiar flujo de salida, un archivo), told/0 (cierra el flujo de salida actual),
    telling/1 (te dice cuál es el flujo de salida actual).
    - see/1 leer archivo, seen/1, seeing/1.
    - ejercicio: triangulo(5).
                    *
                   * *
                  * * *
                 * * * *
                * * * * *

comprime([], []).
comprime([X | Xs, Ys]) :- comp(Xs, X, 1, Ys).

comp([], C, N, [cod(C, N)]).
comp([X | Xs], X, N, Ys) :-
    N1 is N + 1,*/

triangulo(N) :-
    trianguloDibujo(N, N).

trianguloDibujo(0, _).
trianguloDibujo(N, NR) :-
    N > 0,
    N1 is N - 1,
    tab(N1),
    NE is NR - N1,
    stars(NE),
    nl,
    trianguloDibujo(N1, NR).

stars(0).
stars(NE) :-
    NE > 0,
    write(*),
    tab(1),
    NE1 is NE - 1,
    stars(NE1).

% stars(_) :- nl.