% MODELO PARCIAL
% Sueldos Unificados - 2025

% Punto 1
% Base de conocimiento
/*

% trabaja_en(Nombre, Departamento).
trabaja_en(ventas , kyle).
trabaja_en(ventas, trisha).
trabaja_en(ventas, joshua).

trabaja_en(logistica, ian).
trabaja_en(logistica, sherri).

% gana(Nombre, Sueldo)
gana(kyle, 50).
gana(sherri, 60).
gana(gus, 60).
gana(ian, 40).
gana(trisha, 90).
gana(joshua, 55).

puesto(kyle, asalariado(6)).
puesto(sherri, asalariado(7)).
puesto(gus, asalariado(8)).
puesto(ian, jefe([kyle , rob  , ginger])).
puesto(trisha, jefe([ian, gus])).
puesto(joshua, independiente(arquitecto)).

/*
% asalariado(Nombre, horasQueTrabaja)
asalariado(kyle, 6).
asalariado(sherri, 7).
asalariado(gus, 8).

% jefe(Nombre, [personasACargo])
jefe(ian, [kyle , rob  , ginger]).
jefe(trisha, [ian, gus]).

% independiente(Nombre, oficio).
independiente(joshua, arquitecto).

% era mejor  hacerlo todo en un predicado como puesto(nombre , puesto(horas), sueldo) 
% ya q si no lo hago, no utilizar con patter matching 
% si estaria mal hacerlo asi  puesto(nombre , puesto(horas ,sueldo)) xq se complica entender 
*/
% Punto 2
promedio(6, 45).
promedio(7, 60).
promedio(8, 80).

departamento(Departamento):- distinct(Departamento, trabaja_en(Departamento,_)).

esPaganini(Departamento):-
    departamento(Departamento),
    forall(trabaja_en(Departamento,Persona), 
    ganaBien(Persona)).

ganaBien(Persona):-
    gana(Persona, Sueldo),
    puesto(Persona, asalariado(Horas)),
    promedio(Horas, Promedio),
    Sueldo > Promedio.

ganaBien(Persona) :-
    puesto(Persona, jefe(Subordinados)),
    gana(Persona, Sueldo),
    Sueldo > 20 * cantDePersonasACargo(Persona, Cantidad).

ganaBien(Persona):-
    puesto(Persona, independiente(arquitecto)).

ganaBien(Persona):-
    puesto(Persona, independiente(Oficio)),
    Oficio \= arquitecto,
    gana(Persona, Sueldo),
    Sueldo > 70.

cantDePersonasACargo(Persona, Cantidad):-
    puesto(Persona, jefe(PersonasACargo)),
    length(PersonasACargo, Cantidad).

% Punto 3
leGustaTrabajar(kyle , ventas).
leGustaTrabajar(kyle , logistica).
leGustaTrabajar(trisha , ventas).
leGustaTrabajar(joshua , ventas).
leGustaTrabajar(sherri , contabilidad).
leGustaTrabajar(sherri , facturacion).
leGustaTrabajar(sherri , cobranzas).

departamentoEnProblemas(Departamento):-
    departamento(Departamento),
    forall(trabaja_en(Departamento, Persona),
    not(leGustaTrabajar(Persona, Departamento))).

% Punto 4
reorganizar(Deparamento, Presupuesto,Equipo,PresupuestoSobrante):-
    findall(Persona, trabaja_en(Deparamento, Persona), Personas),
    equipoPosible(Personas, Equipo),
    length(Equipo, Cant), Cant >= 2,
    findall(Sueldo, (member(Persona, Equipo), gana(Persona, Sueldo)), Sueldos),
    sumlist(Sueldos, SueldoEquipo),
    SueldoEquipo =< Presupuesto,
    PresupuestoSobrante is Presupuesto - SueldoEquipo.

equipoPosible([], []).
equipoPosible([_|Personas], Equipo):- equipoPosible(Personas, Equipo).
equipoPosible([Persona | Personas], [Persona | Equipos]):- equipoPosible(Personas, Equipos).
*/


% ------------------------------------------------------------------------------------
% trabaja_en(Nombre, Departamento).
trabaja_en(ventas , kyle).
trabaja_en(ventas, trisha).
trabaja_en(ventas, joshua).

trabaja_en(logistica, ian).
trabaja_en(logistica, sherri).

% gana(Nombre, Sueldo)
gana(kyle, 50).
gana(sherri, 60).
gana(gus, 60).
gana(ian, 40).
gana(trisha, 90).
gana(joshua, 55).

puesto(kyle, asalariado(6)).
puesto(sherri, asalariado(7)).
puesto(gus, asalariado(8)).
puesto(ian, jefe([kyle , rob  , ginger])).
puesto(trisha, jefe([ian, gus])).
puesto(joshua, independiente(arquitecto)).

% Punto 2
promedio(6, 45).
promedio(7, 60).
promedio(8, 80).

departamento(Departamento):- distinct(Departamento, trabaja_en(Departamento,_)).

esPaganini(Departamento):-
    departamento(Departamento),
    forall(trabaja_en(Departamento,Persona), 
    ganaBien(Persona)).

ganaBien(Persona):-
    gana(Persona, Sueldo),
    puesto(Persona, Puesto),
    criterioGanaBien(Sueldo,Puesto).

criterioGanaBien(Sueldo, asalariado(Horas)):-
    promedio(Horas, Promedio),
    Sueldo > Promedio.

criterioGanaBien(Sueldo, jefe(Subordinados)):-
    length(Subordinados, Cantidad),
    Sueldo > 20 * Cantidad.

criterioGanaBien(Sueldo, independiente(arquitecto)).
criterioGanaBien(Sueldo, independiente(Oficio)):-
    Oficio \= arquitecto,
    Sueldo > 70.

/* 
con mi solucion se repite mucha logica , es mejor hacer un predicado criterioGanaBien que reciba el sueldo 
y el puesto y ahi hacer el pattern matching para cada caso, asi no repito logica en ganaBien

mismo si puesto/3 no se puede hacer esta solucion para no repetir logica
*/

% Punto 3
leGustaTrabajar(kyle , ventas).
leGustaTrabajar(kyle , logistica).
leGustaTrabajar(trisha , ventas).
leGustaTrabajar(joshua , ventas).
leGustaTrabajar(sherri , contabilidad).
leGustaTrabajar(sherri , facturacion).
leGustaTrabajar(sherri , cobranzas).

departamentoEnProblemas(Departamento):-
    departamento(Departamento),
    forall(trabaja_en(Departamento, Persona),
    not(leGustaTrabajar(Persona, Departamento))).

% opcion 2
departamentoEnProblemas2(Departamento):-
    departamento(Departamento),
    not((trabaja_en(Departamento, Persona),
    not(leGustaTrabajar(Persona, Departamento)))).

% baja puntos usar el forall
% para darnos cuneta de usar not antes q forall
% me doy cuneta cuando sea algo asi forall(X, not(P(X))) es lo mismo q not((X, not(P(X))))


% Punto 4
reorganizar(Deparamento, Presupuesto,Equipo,PresupuestoSobrante):-
    findall(Persona, trabaja_en(Deparamento, Persona), Personas),
    equipoPosible(Personas, Equipo),
    length(Equipo, Cant), Cant >= 2,
    findall(Sueldo, (member(Persona, Equipo), gana(Persona, Sueldo)), Sueldos),
    sumlist(Sueldos, SueldoEquipo),
    SueldoEquipo =< Presupuesto,
    PresupuestoSobrante is Presupuesto - SueldoEquipo.

/*
findall(Sueldo, (member(Persona, Equipo), gana(Persona, Sueldo)), Sueldos),
sumlist(Sueldos, SueldoEquipo),

esto se puede extraer en un hecho aparte
asi en reoganix=zar solo lo llamo como costoEquipo(Equipo, SueldoEquipo)

esto se puede hacer tambien con recursion
*/

equipoPosible([], []).
equipoPosible([_|Personas], Equipo):- equipoPosible(Personas, Equipo).
equipoPosible([Persona | Personas], [Persona | Equipos]):- equipoPosible(Personas, Equipos).


equipoPosible2( [Persona | Otras], [Persona, Otra], Presupuesto , LoQueQueda):- 
    member(Otra, Otras), 
    calculoCosto(Persona, Presupuesto, PresupuestoSobrante),
    calculoCosto(Otra, PresupuestoSobrante,LoQueQueda).
% [Persona, Otra] esto hace q sea de al menos dos elementos 


equipoPosible2([_|Personas], Equipo, Presupuesto, PresupuestoSobrante):- 
    calculoCosto(Persona, Presupuesto,PresupuestoSobrante),
    equipoPosible2(Personas, Equipo, PresupuestoSobrante, LoQueQueda).

equipoPosible2([Persona | Personas], [Persona | Equipos], Presupuesto, PresupuestoSobrante):- 
    calculoCosto(Persona, Presupuesto, PresupuestoSobrante),
    equipoPosible2(Personas, Equipos, PresupuestoSobrante, LoQueQueda).

calculoCosto(Persona, Presupuesto,PresupuestoSobrante):-
    gana(Persona, Sueldo),
    PresupuestoSobrante is Presupuesto - Sueldo,
    PresupuestoSobrante >= 0.

reorganizar2(Equipo , Presupuesto, PresupuestoSobrante):-
    findall(Persona, trabaja_en(Deparamento, Persona), Personas),
    equipoPosible2(Equipo, Personas,Presupuesto, PresupuestoSobrante).
    
%esto hace que vuele en reorganizar esta parte:
%     length(Equipo, Cant), Cant >= 2, ya que en equipoPosible2 ya me aseguro que el equipo tenga al menos 2 personas
 