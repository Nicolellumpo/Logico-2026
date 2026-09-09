% MODELO PARCIAL
% Sueldos Unificados - 2025

% Punto 1
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

% era mejor  hacerlo todo en un predicado como puesto(nombre , puesto(horas), sueldo) 
% ya q si no lo hago, no utilizar con patter matching 
% si estaria mal hacerlo asi  puesto(nombre , puesto(horas ,sueldo)) xq se complica entender 

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
    criterioGanaBien(Sueldo, Puesto).

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
reorganizar(Presupuesto,Equipo,PresupuestoSobrante):-
    findall(Persona, trabaja_en(Deparamento, Persona), Personas),
    equipoPosible(Personas, Equipo),
    length(Equipo, Cant), 
    Cant >= 2,
    findall(Sueldo, (member(Persona, Equipo), gana(Persona, Sueldo)), Sueldos),
    sumlist(Sueldos, SueldoEquipo),
    SueldoEquipo =< Presupuesto,
    PresupuestoSobrante is Presupuesto - SueldoEquipo.

equipoPosible([], []).
equipoPosible([_|Personas], Equipo):- equipoPosible(Personas, Equipo).
equipoPosible([Persona | Personas], [Persona | Equipos]):- equipoPosible(Personas, Equipos).
