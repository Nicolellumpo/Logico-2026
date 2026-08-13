% ----------------------------------------------------------------------------------------------------------------
%                                                Clase 3  de Logico - 2026       
%   Temas Vistos:
%       Módulo 4: Predicados de orden superior (not/1 y forall/2).
%       Una introducción al Testeo con PLUnit .            
% ----------------------------------------------------------------------------------------------------------------


% -------------------------------------Predicado Not/1 -------------------------------------------------------
juega(julia, 3). 
juega(beto, 6). 
juega(dodain, 5). 
juega(juana, 15). 
juega(sergio, 3). 
juega(nicole, 67).

yeta(Numero):- not(juega(_, Numero)). 

/*  INVERSIBLE, admite tanto consultas individuales (sí/no) como consultas existenciales */

yetaInversible(Numero):- numeroRuleta(Numero), not(juega(_, Numero)). 

numeroRuleta(Numero):- between(1, 15, Numero). 

% -----------------------------------------Testeo con PLUnit-------------------------------------------------------
nota(pdp, vera, 9).
nota(pdp, dauria, 8).
nota(pdp, krasuk, 6).
nota(pdp, goffredo, 6).
nota(pdp, bardelli, 9).
nota(pdp, gimenez, 2).
nota(pdp, benitez, 2).
nota(pdp, margiotta, 8).
nota(sysop, dauria, 10).
nota(sysop, krasuk, 2).
nota(sysop, goffredo, 9).
nota(discreta, krasuk, 3).
nota(discreta, goffredo, 6).

materia(pdp).
materia(sysop).
materia(discreta).

% Queremos saber cuántos rindieron PDP
cuantosRindieron(Materia, Cuantos):-
    % sin inversibilidad
    % materia(Materia),    
    findall(Persona, nota(Materia, Persona, _), Personas),
    length(Personas, Cuantos).

% Cuántos aprobaron PDP
cuantosAprobaron(Materia, Cuantos):-
    % sin inversibilidad
    % materia(Materia),    
    findall(Persona, (nota(Materia, Persona, Nota), Nota >= 6), Personas),
    length(Personas, Cuantos).
    
% El promedio de notas de una persona
persona(Persona):-distinct(Persona, nota(_, Persona, _)).

promedio(Persona, Promedio):-
    persona(Persona),
    findall(Nota, nota(_, Persona, Nota), Notas),
    sumlist(Notas, Total),
    length(Notas, Cantidad),
    Promedio is Total / Cantidad.

% Otra forma
cuantosRindieronPiola(Materia, Cuantos):-
    materia(Materia),    
    aggregate_all(count, nota(Materia, _, _), Cuantos).

cuantosAprobaronPiola(Materia, Cuantos):-
    materia(Materia),    
    aggregate_all(count, (nota(Materia, _, Nota), Nota >= 6), Cuantos).
    
% Puede ir a medalla de honor (promedio > 7)
medallaDeHonor(Persona):-
    persona(Persona),
    aggregate_all(resumen(count, sum(Nota)), nota(_, Persona, Nota), resumen(Cantidad, Total)), 
    Promedio is Total / Cantidad,
    Promedio > 7.

% https://cs.fit.edu/~pkc/classes/ai/swi-prolog/Manual/aggregate.html
% count
% sum
% min
% max
% set

% Una materia amena se da si promocionan más de 3 personas
materiaAmena(Materia):-
    materia(Materia),
    aggregate_all(count, (nota(Materia, _, Nota), Nota > 7), CantidadPromocionan),
    CantidadPromocionan > 3.

% ?- materiaAmena(Materia).
% Materia = pdp ;
% false.

% materia heavy, si la nota más alta es < 8
materiaHeavy(Materia):-
    materia(Materia),
    aggregate_all(max(Nota), nota(Materia, _, Nota), MayorNota),
    MayorNota < 8.

% ?- materiaHeavy(Materia).
% Materia = discreta.

% Quiénes promocionan: sacaron más de 7 en cualquier materia
quienesPromocionanAlguna(Personas):-
    aggregate_all(set(Persona), (nota(_, Persona, Nota), Nota > 7), Personas).

% quienesPromocionanAlguna(Personas)
% Personas = [dauria, goffredo, margiotta, vera].

% En lugar de set usamos un bag
quienesPromocionanAlguna2(Personas):-
    aggregate_all(bag(Persona), (nota(_, Persona, Nota), Nota > 7), Personas).

% se repiten
% quienesPromocionanAlguna2(Personas)
% Personas = [vera, dauria, bardelli, margiotta, dauria, goffredo].


% -------------------------------------------------------------------------------------------------------------------------
%                                               TESTS
% -------------------------------------------------------------------------------------------------------------------------
:- begin_tests(clase3).

test("Promedio de una persona", nondet):-
    promedio(dauria, 9),    % 2 notas
    promedio(goffredo, 7),  % 3 notas, ya es medio redundante
    promedio(vera, 9).      % una sola nota, de desconfiado

test("Cuántos rindieron PDP"):-cuantosRindieronPiola(pdp, 8).

test("Cuántos aprobaron PDP"):-cuantosAprobaronPiola(pdp, 6).

test("Medallas de honor", set(Persona = [vera, dauria, bardelli, margiotta])):-medallaDeHonor(Persona).

test("Materias amenas", set(Materia = [pdp])):-materiaAmena(Materia).

test("Materias heavies", set(Materia = [discreta])):-materiaHeavy(Materia).

test("Quiénes promocionan alguna - con set"):-quienesPromocionanAlguna([bardelli, dauria, goffredo, margiotta, vera]).

test("Quiénes promocionan alguna - con bag", nondet):-
    quienesPromocionanAlguna2(Personas), 
    member(bardelli, Personas),
    member(dauria, Personas),
    member(goffredo, Personas),
    member(margiotta, Personas),
    member(vera, Personas).

:- end_tests(clase3).

