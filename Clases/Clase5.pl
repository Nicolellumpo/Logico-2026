% ----------------------------------------------------------------------------------------------------------------
%                                                Clase 5  de Logico - 12/08/2026       
%   Temas Vistos:
%        Modulo 6 : Delegacion. Acoplamiento. Code smells. Repaso de últimas dudas.         
% ----------------------------------------------------------------------------------------------------------------

% -------------------------------------------------------------------------------------------------------------------------
%                                               EJEMPLO AUTOMATAS NO DETERMINISTAS 
% -------------------------------------------------------------------------------------------------------------------------
/** Definición del lenguaje 

M = ({1, 2, 3, 4}, {a, b}, δ, 1, {2}), where δ is given as;
δ (1, a) = 2,
δ (1, a) = 3,
δ (1, a) = 4,
δ (3, b) = 1,
δ (4, b) = 2,
δ (5, b) = 2.

*/

% transicion: estado origen --Token--> estado destino
transicion(1, a, 3).
transicion(1, a, 2).
transicion(1, a, 4).
transicion(4, b, 2).
transicion(3, b, 2).
transicion(3, b, 1).

% estados
estado(1).
estado(2).
estado(3).
estado(4).

/* 
   Los estados inicial y finales se determinan con hechos,
   es parte de lo que el negocio determina, no se pueden inferir
*/
estadoInicial(1).
estadoFinal(2).

% Verifica si una palabra pertenece al lenguaje
esValida(Palabra):-estadoInicial(EstadoInicial), parsear(Palabra, EstadoInicial).

parsear([], Estado):-estadoFinal(Estado).
parsear([Token|Tokens], Estado):-
    transicion(Estado, Token, EstadoSiguiente),
    % write('Token '),
    % write(Token),
    % write(' | δ '),
    % write(Estado),
    % write(' => '),
    % writeln(Siguiente),
    parsear(Tokens, EstadoSiguiente).

% -------------------------------------------------------------------------------------------------------------------------
%                                               EJEMPO DE DISEÑO
% -------------------------------------------------------------------------------------------------------------------------

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

aprobo(Alumno, Anio):-
    forall(materia(Materia), (nota(Materia, Alumno, Nota), Nota >= 6)).
% aprobo es un predicado muy acoplado , mejor abstraer la logica afuera

aproboMateria(Alumno, Materia):-
    nota(Materia, Alumno, Nota),
    last(Notas,Nota),
    Nota >= 6.

aprobo1(Alumno, Anio):-
    forall(materia(Materia), aproboMateria(Alumno, Materia)).



% -------------------------------------------------------------------------------------------------------------------------
%                                               CODE SMELLS
% -------------------------------------------------------------------------------------------------------------------------

todosSiguenA(Rey): personaje(Rey), not((personaje(Personaje), not(sigueA(Personaje, Rey)))). 
% al pedo usar doble not , mejor usar forall, es mas legible y menos acoplado

sigueA(Alguien, Alguien). 
sigueA(lyanna, jon). 
sigueA(jorah, daenerys).

% forma correcta de escribir el predicado todosSiguenA
todosSiguenA(Rey) :personaje(Rey), forall((personaje(Personaje), sigueA(Personaje, Rey))).

% -------------------------------------------------------------------------------------------------------------------------
%                                               EJEMPLO DE REPETICION DE LOGICA
% -------------------------------------------------------------------------------------------------------------------------
baresCopados(Ciudad, Bares): findall(bar(CantVarCer), (puntoDeInteres(bar(CantVarCer), Ciudad), CantVarCer > 4), Bares). 

museosCopados(Ciudad, Museos) : findall(museo(cienciasNaturales), puntoDeInteres(museo(cienciasNaturales), Ciudad), Museos). 

ciudadInteresante(Ciudad) :antigua(Ciudad), baresCopados(Ciudad, Bares), 
                           museosCopados(Ciudad, Museos), 
                           length(Bares, CantidadBares2), 
                           length(Museos, CantidadMuseos), 
                           CantidadLugaresCopados is CantidadBares + CantidadMuseos, 
                           CantidadLugaresCopados > 10.

% mejor forma hacer

ciudadInteresante(Ciudad) : antigua(Ciudad), puntosCopadas(Ciudad, length(Puntos, CantidadCosas > 10)).

puntosCopadas(Ciudad, Puntos) : findall(Punto, (puntoDeInteres(Punto, Ciudad), copada(Punto)), Puntos).

copada(museo(cienciasNaturales)).

copada(bar(VariedadesCerveza)) :- VariedadesCerveza > 4.

% -------------------------------------------------------------------------------------------------------------------------
%                                               TESTS
% -------------------------------------------------------------------------------------------------------------------------
:- begin_tests(automatas).

test(camino_simple_inicial_final_parsea_ok, nondet):-
    esValida([a]).

test(camino_compuesto_inicial_final_parsea_ok, nondet):-
    esValida([a, b]).

test(camino_compuesto_en_varios_ciclos_inicial_final_parsea_ok, nondet):-
    esValida([a, b, a, b, a]).

test(palabra_que_no_parsea_porque_no_transiciona_a_ningun_estado, fail):-
    esValida([a, a]).

test(palabra_que_no_parsea_porque_no_transiciona_a_ningun_estado_mas_de_dos_transiciones, fail):-
    esValida([a, a, a]).

test(palabra_que_no_parsea_por_caracter_invalido, fail):-
    esValida([c]).

test(palabra_que_no_parsea_por_vacia, fail):-
    esValida([]).

:- end_tests(automatas).
    