% ----------------------------------------------------------------------------------------------------------------
%                                                Clase 2  de Logico - 2026       
%   Temas Vistos:
%      Módulo 3: Estructuras de datos. Individuos simples y compuestos.    
%      Módulo 4: Predicados de orden superior (not/1 y forall/2).
%      Una introducción al Testeo con PLUnit .  
% ----------------------------------------------------------------------------------------------------------------

% -------------------------------------Base de Conocimiento-------------------------------------------------------
% natacion: estilos (lista), metros nadados, medallas 
practica(ana, natacion([pecho, crawl], 1200, 10)). 
practica(luis, natacion([perrito], 200, 0)). 
practica(vicky,  natacion([crawl, mariposa, pecho, espalda], 800, 0)). 

% fútbol: medallas, goles marcados, veces que fue expulsado 
practica(deby, futbol(2, 15, 5)). 
practica(mati, futbol(1, 11, 7)). 

% rugby: posición que ocupa, medallas 
practica(zaffa, rugby(pilar, 0)). 


nadador(Quien):-practica(Quien, natacion(_, _, _)). 

medallas(Alguien, Medallas):- practica(Alguien, Deporte), 
                              cuantasMedallas(Deporte, Medallas). 

cuantasMedallas(natacion(_, _, Medallas), Medallas). 
cuantasMedallas(futbol(Medallas, _, _), Medallas). 
cuantasMedallas(rugby(_, Medallas), Medallas). 

buenDeportista(Alguien):- practica(Alguien, Deporte), esBueno(Deporte). 

esBueno(natacion(Estilos, _, _)):- length(Estilos, CantidadEstilos), CantidadEstilos > 3. 
esBueno(natacion(_, metros, _)):- metros > 1000. 
esBueno(futbol(_, Goles, Expulsiones)):- Valor is Goles - Expulsiones, Valor > 5. 
esBueno(rugby(pilar, _)). 
esBueno(rugby(wing, _)). 

/*
Las últimas dos cláusulas también pueden escribirse de esta manera: 
esBueno(rugby(Puesto, _)):-member(Puesto, [pilar, wing]). 
*/

/* 
 -------------------------------------------------------------------------------------------------------------------------
                                                Casos de prueba
 -------------------------------------------------------------------------------------------------------------------------
 cuantasMedallas(rugby(hooker, 10), Medallas). 
 cuantasMedallas(natacion([crawl, espalda, mariposa], 1800, 6), Medallas). 
 buenDeportista(Alguien). 

*/ 

% -------------------------------------------------------------------------------------------------------------------------
%                                               TESTS
% -------------------------------------------------------------------------------------------------------------------------
:- begin_tests(clase2).


:- end_tests(clase2).