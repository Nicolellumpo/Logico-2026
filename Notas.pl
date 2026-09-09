%Modulo 4 - : Predicados de orden superior (not/1, forall/2 y findall/3)

nota(pdp, vera, 9).
nota(pdp, dauria, 8).
nota(pdp, krasuk, 6).
nota(pdp, bardelli, 9).
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
    materia(Materia),    
    findall(Persona, nota(Materia, Persona, _), Personas),
    length(Personas, Cuantos).

% Cuántos aprobaron PDP
cuantosAprobaron(Materia, Cuantos):-
    materia(Materia),
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