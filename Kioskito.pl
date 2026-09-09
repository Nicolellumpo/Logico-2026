% Lógica de negocio
% Punto 1
atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).
atiende(lucas, martes, 10, 20).
atiende(juanC, sabados, 18, 22).
atiende(juanC, domingos, 18, 22).
atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).
atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).
atiende(martu, miercoles, 23, 24).

atiende(vale, Dia, HorarioInicio, HorarioFinal):-atiende(dodain, Dia, HorarioInicio, HorarioFinal).
atiende(vale, Dia, HorarioInicio, HorarioFinal):-atiende(juanC, Dia, HorarioInicio, HorarioFinal).

% Punto 2: quién atiende el kiosko... (2 puntos)
quienAtiende(Persona, Dia, HorarioPuntual):-
  atiende(Persona, Dia, HorarioInicio, HorarioFinal),
  between(HorarioInicio, HorarioFinal, HorarioPuntual).

% Punto 3: Forever alone (2 puntos)
foreverAlone(Persona, Dia, HorarioPuntual):-
  quienAtiende(Persona, Dia, HorarioPuntual),
  not((quienAtiende(OtraPersona, Dia, HorarioPuntual), 
  Persona \= OtraPersona)).

% Punto 4: posibilidades de atención (3 puntos / 1 punto)
posibilidadesAtencion(Dia, Personas):-
  findall(Persona, distinct(Persona, quienAtiende(Persona, Dia, _)), PersonasPosibles),
  combinar(PersonasPosibles, Personas).

combinar([], []).
combinar([Persona|PersonasPosibles], [Persona|Personas]):-combinar(PersonasPosibles, Personas).
combinar([_|PersonasPosibles], Personas):-combinar(PersonasPosibles, Personas).

% Punto 5: ventas / suertudas (4 puntos)
venta(dodain, fecha(10, 8), [golosinas(1200), cigarrillos(jockey), golosinas(50)]).
venta(dodain, fecha(12, 8), [bebidas(true, 8), bebidas(false, 1), golosinas(10)]).
venta(martu, fecha(12, 8), [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
venta(lucas, fecha(11, 8), [golosinas(600)]).
venta(lucas, fecha(18, 8), [bebidas(false, 2), cigarrillos([derby])]).

personaSuertuda(Persona):-
  vendedora(Persona),
  forall(venta(Persona, _, [Venta|_]), 
         ventaImportante(Venta)).

vendedora(Persona):-venta(Persona, _, _).

ventaImportante(golosinas(Precio)):-Precio > 100.
ventaImportante(cigarrillos(Marcas)):-length(Marcas, Cantidad), Cantidad > 2.
ventaImportante(bebidas(true, _)).
ventaImportante(bebidas(_, Cantidad)):-Cantidad > 5.

% Tests
:-begin_tests(kioskito).
test(atienden_los_viernes, set(Persona = [vale, dodain, juanFdS])):-
  atiende(Persona, viernes, _, _).

test(personas_que_atienden_un_dia_puntual_y_hora_puntual, set(Persona = [vale, dodain, leoC])):-
  quienAtiende(Persona, lunes, 14).

test(dias_que_atiende_una_persona_en_un_horario_puntual, set(Dia = [lunes, miercoles, viernes])):-
  quienAtiende(vale, Dia, 10).

test(una_persona_esta_forever_alone_porque_atiende_sola, set(Persona=[lucas])):-
  foreverAlone(Persona, martes, 19).

test(persona_que_no_cumple_un_horario_no_puede_estar_forever_alone, fail):-
  foreverAlone(martu, miercoles, 22).
test(posibilidades_de_atencion_en_un_dia_muestra_todas_las_variantes_posibles, set(Personas=[[],[dodain],[dodain,leoC],[dodain,leoC,martu],[dodain,leoC,martu,vale],[dodain,leoC,vale],[dodain,martu],[dodain,martu,vale],[dodain,vale],[leoC],[leoC,martu],[leoC,martu,vale],[leoC,vale],[martu],[martu,vale],[vale]])):-
  posibilidadesAtencion(miercoles, Personas).

test(personas_suertudas, set(Persona = [martu, dodain])):-
  personaSuertuda(Persona).

:-end_tests(kioskito).