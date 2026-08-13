/* ------------------------------------------------------------------------------------------------------------------------
                                               Clase 1  de Logico - 2026  
   Temas Vistos: 
   Modulo 1 : Predicados. Individuos. Consultas. Universo Cerrado.
   Módulo 2 : Variables. Consultas Existenciales. Reglas simples y compuestas. Inversibilidad. 
 ------------------------------------------------------------------------------------------------------------------------ */

% predicado poliádico: expresa relaciones entre individuos
% actuo/2 es el predicado
% hay varias cláusulas
actuo(leoDiCaprio, wolfOfWallStreet).
actuo(margotRobbie, wolfOfWallStreet).
actuo(jonahHill, wolfOfWallStreet).
actuo(leoDiCaprio, onceUponATimeInHollywood).
actuo(bradPitt, onceUponATimeInHollywood).
actuo(margotRobbie, onceUponATimeInHollywood).
actuo(joePesci, goodFellas).
actuo(robertDeNiro, goodFellas).
actuo(rayLiotta, goodFellas).
actuo(lorraineBracco, goodFellas).
actuo(leoDiCaprio, catchMeIfYouCan).
actuo(tomHanks, catchMeIfYouCan).
actuo(michaelKeaton, birdman).
actuo(emmaStone, birdman).

% predicado monádico: expresa una característica de un individuo
% ganoElOscar/1
ganoElOscar(birdman).

% un suertude es aquel que actuó en una película que ganó el Oscar
% p ^ q => r
% p -> actuó en una película
% q -> ganó el Oscar
% r -> es suertude
% predicado monádico
% suertude/1
suertude(Persona) :-
  actuo(Persona, Pelicula) ,
  ganoElOscar(Pelicula).

/* 
 -------------------------------------------------------------------------------------------------------------------------
                                                Casos de prueba
 -------------------------------------------------------------------------------------------------------------------------

  suertude(birdman).    
  suertude(emmaStone).

*/ 

% -------------------------------------------------------------------------------------------------------------------------
%                                               TESTS
% -------------------------------------------------------------------------------------------------------------------------
:- begin_tests(clase1).


:- end_tests(clase1).
