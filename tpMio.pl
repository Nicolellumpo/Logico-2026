%Tp Prolong

%--------------------------------------------PUNTO 1--------------------------------------------------
%GRUPAL
%Modelado de BASE DE CONOCIMIENTO
cocineros(ana).
cocineros(bruno).	
cocineros(carla).
cocineros(diego).
cocineros(jorge).

cocina(ana, italiana).
cocina(bruno, japonesa).
cocina(carla, italiana).
cocina(carla, argentina).
cocina(diego, italiana).
cocina(jorge, argentina).

tecnicas(ana, corteCuchillo).
tecnicas(ana, mezcla).	
tecnicas(ana, marinado).
tecnicas(ana, horneado).

tecnicas(bruno, corteCuchillo).
tecnicas(bruno, mezcla).
tecnicas(bruno, fermentacion).

tecnicas(carla, corteCuchillo).
tecnicas(carla, manejoParrilla).

tecnicas(diego, corteCuchillo).
tecnicas(diego, manejoParrilla).
tecnicas(diego, fermentacion).

tecnicas(jorge, corteCuchillo).
tecnicas(jorge, manejoParrilla).
tecnicas(jorge, horneado).

/*no definimos a emma ya que por el principio de universo cerrado todo lo que no
definimos en la base de conocimiento se presupone falso*/

%-------------------------------------------PUNTO 6---------------------------------------------------
%GRUPAL
%MODELAR PLATOS DE COCINERO
/*
plato(nombre , Funtor())

Funtores:
parrilla(animal coninado).
ensalada(apta vegetarianos , dif de confeccion).
pasta(calorias).
sushi( num de piezas , si incluye salsa de soja).
ramen( diametro del tazon).
*/

plato(ana , pasta(400)).
plato(ana , ensalada(aptoVegano , 1)).
plato(ana , ensalada(noAptoVegano , 2)).

plato(bruno , sushi(8 , incluyeSalsaSoja)).
plato(bruno , ramen(20)).
plato(bruno , ensalada(aptoVegano , 1)).

plato(carla , pasta(350)).
plato(carla , parrilla(cerdo)).
plato(carla , ensalada(noAptoVegano ,3)).

plato(jorge , parrilla(cerdo)).
plato(jorge , parrilla(res)).

% A diego no lo definimos xq al no preparar platos no hace falta, ya que por el principio de universo cerrado
% todo lo que no definimos en la base de conocimiento se presupone falso.

%--------------------------------------------PUNTO 2--------------------------------------------------
%si un cocinero domina corte a cuchillo, mezcla y se le suma una condición particular que es 
%o bien domina fermentación o bien cocina italiana. El predicado debe ser inversible

cocineroExperto(Cocinero):- cocineros(Cocinero),
	tecnicas(Cocinero, corteCuchillo),
	tecnicas(Cocinero, mezcla),
	tecnicas(Cocinero, fermentacion).	

cocineroExperto(Cocinero):- cocineros(Cocinero),
	tecnicas(Cocinero, corteCuchillo),
	tecnicas(Cocinero, mezcla),
	cocina(Cocinero, italiana).	

%-------------------------------------------PUNTO 4---------------------------------------------------
%Integrante 2
%Se satisface para una técnica cuando es dominada por todos los cocineros. El predicado debe ser inversible.
tecnicaUniversal(Tecnica):- 
	tecnicas(_, Tecnica), 
	forall(cocineros(Cocinero), tecnicas(Cocinero,Tecnica)).

%-------------------------------------------PUNTO 7---------------------------------------------------  

% esto me hace que si yo hago una consulta q relaciona a un cocinero 
% con cada uno de sus platos y calcula cuán complejo es prepararlo, 

complejidad(parrilla(res), 90).
complejidad(parrilla(cerdo), 80).

complejidad(ensalada(noAptoVegano, 1), 50).
complejidad(ensalada(noAptoVegano, 2), 65).
complejidad(ensalada(noAptoVegano, 3), 70).

complejidad(pasta(Calorias), Calorias).

complejidad(ramen(Diametro), Diametro).

complejidad(ensalada(_, Nivel), Complejidad):-
    Complejidad is Nivel * 40.

complejidad(sushi(Piezas, _), Complejidad):-
    Complejidad is Piezas * 10.

/*complejidadPlato(Cocinero, Plato, Complejidad):-
    plato(Cocinero, Plato),
    complejidad(Plato, Complejidad).*/

%-------------------------------------------PUNTO 8---------------------------------------------------
%Integrante 2
/*se cumple cuando un plato le gana a otro. Sabemos que el orden es parrilla > pasta > sushi > ensalada. 
  Si es del mismo tipo, gana por complejidad. El predicado debe ser inversible.*/


% ----------------VER Q ANDE BIEN ESTO----------------------
orden(parrilla, 5).
orden(pasta, 4).
orden(sushi, 3).
orden(ensalada, 2).
orden(ramen, 1).

tipo(parrilla(_), parrilla).
tipo(pasta(_), pasta).
tipo(sushi(_, _), sushi).
tipo(ensalada(_, _), ensalada).
tipo(ramen(_), ramen).

% Gana por orden
platoGana(Plato , OtroPlato):- 
	tipo(Plato, Tipo1), 
	tipo(OtroPlato, Tipo2), 
	Tipo1 \= Tipo2,
	orden(Tipo1, NumeroDeOrden1), 
	orden(Tipo2, NumeroDeOrden2),
	NumeroDeOrden1 > NumeroDeOrden2.

%Mismo Tipo  y gana por complejidad
platoGana(Plato , OtroPlato):- 
	tipo(Plato, Tipo), tipo(OtroPlato, Tipo),
	complejidad(Plato, Complejidad1), 
	complejidad(OtroPlato , Complejidad2),
	Complejidad1 > Complejidad2.

%-------------------------------------------PUNTO 11--------------------------------------------------
%Integrante 2
% relaciona un cocinero y una complejidad y arma la lista de posibles platos a cocinar por ese cocinero 
%que entre la sumatoria de complejidades individuales de los platos no superen la complejidad máxima establecida. 
%Puede ofrecer uno, algunos o ninguno. Tiene que evaluar todas las combinaciones posibles. El predicado debe ser inversible.

platosACocinar(Cocinero , TotalComplejidad  , Platos) :- cocineros(Cocinero),
	findall(Plato, plato(Cocinero, Plato) ,PlatosPosibles) ,  
	combinar(PlatosPosibles , Platos),
	sumarComplejidad(Platos  , Complejidad),
	Complejidad =< TotalComplejidad.

combinar([], []).
combinar([Plato|PlatosPosibles], [Plato|Platos]):-combinar(PlatosPosibles, Platos).
combinar([_|PlatosPosibles], Platos):-combinar(PlatosPosibles, Platos).

sumarComplejidad([], 0).
sumarComplejidad([Plato|Platos], Total):- 
	complejidad(Plato, SumaResto),
	sumarComplejidad(Platos, ComplejidadPlato),
	Total is ComplejidadPlato + SumaResto.
