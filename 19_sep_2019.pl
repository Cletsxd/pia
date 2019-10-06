% [19-septiembre-2019]
/*
Hechos:

% loc_en(X, Y): la ciudad X está localizada en Y.
loc_en(atlanta,georgia).
loc_en(houston,texas).
loc_en(austin,texas).
loc_en(boston,massachussets).
loc_en(xalapa,veracruz).
loc_en(veracruz,veracruz).

- true. Se puede deducir y la meta no tiene variables.
- false. No se puede deducir. Se asume el CWA*.
- Substitución de respuesta. Se puede deducir y la meta tiene variables.
    ?- loc_en(Ciudad, texas).
    Ciudad = houston ;
    Ciudad = austin ;
    false.
- Datos y programas (son cláusulas) tienen la misma representación.
- Extienden la semántica de localizado en:
    loc_en(X, usa) :- loc_en(X, georgia).
- El mismo predicado loc_en/2 nos sirve para computar diferentes consultas.
- Metas negativas: not (\+).
    ?- \+ loc_en(xalapa,usa).
    true.
    ?- \+ loc_en(C,usa). % C, cuantificada existencialmente
    false.
    ?- loc_en(C,norteamerica), \+ loc_en(C,usa).
    C = xalapa ;
    C = veracruz ;
    false.
- Algunas metas se pueden convertir en reglas.
- TAREA: trace z/2 diapositiva 14, pia_3.pdf
*/