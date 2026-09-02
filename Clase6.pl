% MODELO PARCIAL
% Sueldos Unificados - 2025

% Punto 1
% Base de conocimiento

% trabaja_en(Nombre, Departamento).
trabaja_en(kyle, ventas).
trabaja_en(trisha, ventas).
trabaja_en(joshua, ventas).

trabaja_en(ian, logistica).
trabaja_en(sherri, logistica).

% gana(Nombre, Sueldo)
gana(kyle, 50).
gana(sherri, 60).
gana(gus, 60).
gana(ian, 40).
gana(trisha, 90).
gana(joshua, 55).

% asalariado(Nombre, horasQueTrabaja)
asalariado(kyle, 6).
asalariado(sherri, 7).
asalariado(gus, 8).

% jefe(Nombre, [personasACargo])
jefe(ian, [kyle , rob  , ginger]).
jefe(trisha, [ian, gus]).

% independiente(Nombre, oficio).
independiente(joshua, arquitecto).

% Punto 2
promedio(6, 45).
promedio(7, 60).
promedio(8, 80).

esPaganini(Departamento):-
    forall(trabaja_en(Persona, Departamento), 
    ganaBien(Persona)).

ganaBien(Persona):-
    asalariado(Persona, Horas),
    gana(Persona, Sueldo),
    promedio(Horas, Promedio),
    Sueldo > Promedio.

ganaBien(Persona) :-
    jefe(Persona, Subordinados),
    gana(Persona, Sueldo),
    Sueldo > 20 * cantDePersonasACargo(Persona, Cantidad).

ganaBien(Persona):-
    independiente(Persona, arquitecto).

ganaBien(Persona):-
    independiente(Persona, Oficio),
    Oficio \= arquitecto,
    gana(Persona, Sueldo),
    Sueldo > 70.

cantDePersonasACargo(Persona, Cantidad):-
    jefe(Persona, PersonasACargo),
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
    trabaja_en(Persona, Departamento),
    forall(trabaja_en(Persona, Departamento),
    not(leGustaTrabajar(Persona, Departamento))).

% Punto 4
reorganizar(Deparamento, Presupuesto,Equipo,PresupuestoSobrante):-
    findall(Persona, trabaja_en(Persona, Deparamento), Personas),
    equipoPosible(Personas, Equipo),
    length(Equipo, Cant), Cant >= 2,
    findall(Sueldo, (member(Persona, Equipo), gana(Persona, Sueldo)), Sueldos),
    sumlist(Sueldos, SueldoEquipo),
    SueldoEquipo =< Presupuesto,
    PresupuestoSobrante is Presupuesto - SueldoEquipo.

equipoPosible([], []).
equipoPosible([_|Personas], Equipo):- equipoPosible(Personas, Equipo).
equipoPosible([Persona | Personas], [Persona | Equipos]):- equipoPosible(Personas, Equipos).


