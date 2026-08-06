% ------------------------------------------------------------------------------------------------------------------------
%                                                Clase 4  de Logico - 2026  
%   Temas Vistos: 
%   Recursividad, Listas, Predicados de Orden Superior (Findall)
% ------------------------------------------------------------------------------------------------------------------------

% --------------------------------------------Ejemplo 1 de Recursividad---------------------------------------------------
% Base de Conocimiento
progenitor(tatara, bisa).
progenitor(homero, bart). 
progenitor(homero, lisa).
progenitor(homero, maggie).  
progenitor(abe, homero). 
progenitor(abe, jose).

%Inversible totalmente
ancestro(Padre, Hijo) :- progenitor(Padre , Hijo).                 % Caso Base 
ancestro(Ancestro, Persona):- progenitor(Ancestro, Descendiente),  % Caso Recursivo
                              ancestro(Descendiente, Persona).

% --------------------------------------------Ejemplo 2 de Recursividad---------------------------------------------------
% Base de Conocimiento
distancia(buenosAires, puertoMadryn, 1300). 
distancia(puertoMadryn, puertoDeseado, 732). 
distancia(puertoDeseado, rioGallegos, 736). 
distancia(puertoDeseado, calafate, 979). 
distancia(rioGallegos, calafate, 304). 
distancia(calafate, chalten, 213).

distanciaEntre(Origen, Destino, Distancia) :- distancia(Origen, Destino , Distancia). % Caso Base
distanciaEntre(Origen, Destino, Distancia) :-                                         % Caso Recursivo
    distancia(Origen, PuntoIntermedio, DistanciaIntermedia),
    distanciaEntre(PuntoIntermedio, Destino, DistanciaRestante), 
    Distancia is DistanciaIntermedia + DistanciaRestante.


% --------------------------------------------Ejemplo 1 de Findall---------------------------------------------------
% Base de Conocimiento
costo(cine, 400).
costo(wos,700).
costo(tini, 500).
costo(pool, 350).
costo(bowling,300).
costo(argentina,8000).

actividadesPosibles(Plata,Actividades):- findall(actividad(Actividad, Costo) , 
                                                (costo(Actividad,Costo), Plata >= Costo), 
                                                Actividades).

combinarActividades(ActividadesPosibles, Actividades),aggregate_all(sum(Costo), (member(actividad(_ , Costo) , Actividades), Total), PLata >=Total).%NO HAY Q HACER ESTO
combinarActividades(ActividadesPosibles, Actividades), costoTotal(Actividades, Total), Plata >= Total.

combinarActividades([],[]).
combinarActividades([Actividad | ActividadesPosibles] , [Actividad |Actividades]) :- combinarActividades(ActividadesPosibles , Actividades).
combinarActividades([_ | ActividadesPosibles], Actividades):- combinarActividades(ActvidadesPosibles , Actividades).


% -------------------------------------------------------------------------------------------------------------------------
%                                               TESTS
% -------------------------------------------------------------------------------------------------------------------------
:- begin_tests(clase4).


:- end_tests(clase4).