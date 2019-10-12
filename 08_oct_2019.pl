/* [08-octubre-2019]

- Búsqueda primero en amplitud:
- Contamos con un solo camino candidato.
- Luego, dado un conjunto de caminos candidatos:
	- Si el primer camino contiene un nodo meta como su cabeza, entonces esa es la solución al problema. De otra forma,
	- Eliminar el primer camino del conjunto de caminos candidadtos generar el conjunto de todas las ppsibles extensiones de un paso de este camino.
	- Agregar este conjunto de extensiones al final del aconjunto de cantidatos.
	- Ejecutar la búsqueda primero en amplitud en este nuevo conjunto de caminos candidatos.
- Para generar las extensiones de un solo paso, usemos el predicado predefinido bagof/3.
- bagof(X, Query, R).
* Preguntar por tarea perms/2. Preguntar por formato Latex de comentarios con acento. Y por código.
- Búsquedas optimizadas.
- Heurísticas:
	- Las búsquedas no optimizadas sin ciegas a criterios de soluciones óptimas.
	- Un algoritmo primero el mejor afina la búsqueda en amplitud, expandiendo el mejor candidato.
	- Una función costo s(n, m, c) representa el costo c de moverse de un nodo n al nodo m en el espacio de estados.
	- Se puede diseñar una función heurística h que estime la dificultad de llegar de un nodo n a la meta.
	- La búsqueda puede guiarse entonces minimizando el costo recorrido y la distancia por recorrer.
- Costo y costo estimado
	- f(n) será construida para estimar el costo del mejor camino solución entre el nodo inicial s y el nodo meta t,
		con la restricción de que el camino pase por el nodo n.
	- Supongamos que tal camino existe y que un nodo meta que minimiza su costo es n. Entonces el estimado de f(n)
		puede calcularse como la suma de dos términos:
			f(n) = g(n) + h(n)
		donde g(n) es el costo del camino óptimo de s a n; y h(n) es el costo estimado de un camino óptimo de n a la meta t.
- Representación
- Requiere una representación más elaborada para los nodos de búsqueda:
	- Hoja: I(N, F / G), donde N es un nodo en el espacio de estados, G es g(N) y F es f(N) = G + h(N).
	- Nodo interno: t(N, F / G, Subarboles), donde F es el valor f(N) actualizado por el valor para f(N) del sucesor
		más prometedor. Los subárboles se ordenan de acuerdo a su f-valor.
	- Ejemplo: t(s, 7/0, [I(a, 7/2), I(e, 9/2)])
*/