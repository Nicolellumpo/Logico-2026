% --------------------------------------------Ejemplo 1 -------------------------------------------------------------
actividad(cine). 
actividad(arjona). 
actividad(princesas_on_ice). 
actividad(pool). 
actividad(bowling).

costo(cine, 400). 
costo(arjona, 1750). 
costo(princesas_on_ice, 2500). 
costo(pool, 350). 
costo(bowling, 300). 

actividades(Plata, ActividadesPosibles):- 
    findall(Actividad, actividad(Actividad), Actividades), 
    actividadesPosibles(Actividades, Plata, ActividadesPosibles). 


actividadesPosibles([] , _ , []). 

actividadesPosibles([Actividad|Actividades], Plata, [Actividad|Posibles]):- 
    costo(Actividad, Costo),  
    Plata > Costo,  
    PlataRestante is Plata - Costo, 
    actividadesPosibles(Actividades, PlataRestante, Posibles). 

actividadesPosibles([_|Actividades], Plata, Posibles):- 
    actividadesPosibles(Actividades, Plata, Posibles). 


% --------------------------------------------Ejemplo 2 -------------------------------------------------------------
cocinero(donato). 
cocinero(pietro). 

pirata(felipe, 27). 
pirata(marcos, 39). 
pirata(facundo, 45). 
pirata(tomas, 20). 
pirata(betina, 26). 
pirata(gonzalo, 22). 

bravo(tomas). 
bravo(felipe). 
bravo(marcos).
bravo(betina). 

personasPosibles([donato, pietro, felipe, marcos, facundo, tomas, gonzalo, betina]). 

tripulacionBarco(Tripulacion):- 
    personasPosibles(Personas),
    tripulacion(Personas, Tripulacion).

tripulacion([], []). 
tripulacion([Posible|Posibles], [Posible|Tripulantes]):- 
    puedeSubirAlBarco(Posible),  
    tripulacion(Posibles, Tripulantes). 
tripulacion([_|Posibles], Tripulantes):- 
    tripulacion(Posibles, Tripulantes). 

puedeSubirAlBarco(Persona):- cocinero(Persona). 
puedeSubirAlBarco(Persona):- pirata(Persona, _), bravo(Persona). 
puedeSubirAlBarco(Persona):- pirata(Persona, Edad), Edad > 40. 

% --------------------------------------------Ejemplo 3 -------------------------------------------------------------
maplistF(PredTransf, Original, Nueva):- 
    findall(Result, (member(Elem, Original),  call(PredTransf, Elem, Result)), Nueva).
% Consultas: 
% maplistF(length, [[1], [2, 6], []],  Transf). 
% maplistF(between(3), [5, 6], X). 
% maplistF(plus(1), [5, 6, 7], Result). 

filter(Criterio, ListaOriginal, ListaNueva):- 
    findall(Elem,  (member(Elem, ListaOriginal), call(Criterio, Elem)), ListaNueva). 
% Consulta: filter(>(5), [1, 2, 3, 4, 5, 6, 7], ListaNueva).

/* filter2 tenga explosión combinatoria, en cada elemento de la lista original elijo y no elijo 
 considerarla como parte de la solución. Esto nos arma la combinatoria de posibles sublistas*/
filter2(_, [], []). 
filter2(Criterio, [X|Original], [X|Nueva]):- 
    call(Criterio, X), 
    filter2(Criterio, Original, Nueva). 
filter2(Criterio, [_|Original], Nueva):- filter2(Criterio, Original, Nueva). 


%Esto corta el árbol de soluciones posibles: cada vez que tengo un elemento de la lista, considero que sólo 
% puede haber un curso de acción válido: o lo filtro por no cumplir el criterio, o lo incluyo. 
%Entonces filter/3 pasa a parecerse más a una función con una única solución
filter3(_, [], []). 
filter3(Criterio, [X|Original], [X|Nueva]):- 
    call(Criterio, X), 
    filter3(Criterio, Original, Nueva). 
filter3(Criterio, [X|Original], Nueva):- 
    not(call(Criterio, X)),
    filter3(Criterio, Original, Nueva). 
