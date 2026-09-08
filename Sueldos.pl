
% -------------------------------------------------------------------------------------------------------------------------
%                                                   Temas 2
% -------------------------------------------------------------------------------------------------------------------------

%---------------------------------------------------Punto 1---------------------------------------------------
% trabaja_en(Nombre, Departamento).
trabaja_en(ventas , kyle).
trabaja_en(ventas, trisha).
trabaja_en(ventas, ian).

trabaja_en(logistica, sherri).
trabaja_en(logistica, joshua).

% gana(Nombre, Sueldo)
gana(kyle, 30).
gana(sherri, 90).
gana(gus, 60).
gana(ian, 85).
gana(trisha, 50).
gana(joshua, 35).

puesto(kyle, asalariado(7)).
puesto(sherri, asalariado(6)).
puesto(gus, asalariado(8)).
puesto(ian, jefe([kyle , rob ])).
puesto(trisha, jefe([ian, gus, ginger])).
puesto(joshua, independiente(arquitecto)).

%---------------------------------------------------Punto 2---------------------------------------------------

esFeliz(Departamento):-
    trabaja_en(Departamento, Persona),
    forall(trabaja_en(Departamento,Persona), 
    criterioFeliz(Persona)).

criterioFeliz(Persona):-
    puesto(Persona, asalariado(Horas)),
    Horas =< 7.

criterioFeliz(Persona):-
    puesto(Persona, jefe(_)),
    gana(Persona, Sueldo),
    Sueldo >= 50.

criterioFeliz(Persona):-
    puesto(Persona, jefe(Empleados)),
    length(Empleados, Cantidad),
    Cantidad =< 3.

criterioFeliz(Persona):-
    puesto(Persona, independiente(arquitecto)).
criterioFeliz(Persona):-
    puesto(Persona, independiente(ingeniero)).

%---------------------------------------------------Punto 3---------------------------------------------------
quiere_ganar(kyle , 70).
quiere_ganar(trisha , 250).
quiere_ganar(sherri , 200).
quiere_ganar(ian , 60).
quiere_ganar(gus , 70).
quiere_ganar(joshua , 70).

esta_en_problemas(Departamento):-
    trabaja_en(Departamento, Persona),
    forall(trabaja_en(Departamento, Persona), not(esta_satifecha(Persona))).

esta_satifecha(Persona):-
    gana(Persona, Sueldo),
    quiere_ganar(Persona, SueldoDeseado),
    Sueldo * 2 < SueldoDeseado.

%---------------------------------------------------Punto 4---------------------------------------------------

reorganizar(CantPersonas,Equipo,Presupuesto):-
    findall(Persona, trabaja_en(Departamento, Persona), Personas),
    equipoPosible(Personas, Equipo),
    length(Equipo, CantPersonas),
    findall(Sueldo, (member(Persona, Equipo), gana(Persona, Sueldo)), Sueldos),
    sumlist(Sueldos, Presupuesto).
    

equipoPosible([], []).
equipoPosible([_|Personas], Equipo):- equipoPosible(Personas, Equipo).
equipoPosible([Persona | Personas], [Persona | Equipos]):- equipoPosible(Personas, Equipos).
