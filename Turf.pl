
% Punto 1: 2 puntos
jockey(valdivieso, 155, 52).
jockey(leguisamo, 161, 49).
jockey(lezcano, 149, 50).
jockey(baratucci, 153, 55).
jockey(falero, 157, 52).

representa(valdivieso, elTute).
representa(falero, elTute).
representa(lezcano, lasHormigas).
representa(baratucci, elCharabon).
representa(leguisamo, elCharabon).

caballo(botafogo).
caballo(old_man).
caballo(energica).
caballo(mat_boy).
caballo(yatasto).

prefiere(botafogo, Jockey):-jockey(Jockey, _, Peso), Peso < 52.
prefiere(botafogo, baratucci).
prefiere(old_man, Jockey):-jockey(Jockey, _, _), atom_length(Jockey, CantidadLetras), CantidadLetras > 7.
prefiere(energica, Jockey):-jockey(Jockey, _, _), not(prefiere(botafogo, Jockey)).
prefiere(mat_boy, Jockey):-jockey(Jockey, Altura, _), Altura > 170.
% por universo cerrado no tiene sentido escribir una cláusula para Yatasto dado que lo que no está en 
% la base de conocimientos se presume falso

gano(botafogo, granPremioNacional).
gano(botafogo, granPremioRepublica).
gano(old_man, granPremioRepublica).
gano(old_man, campeonatoPalermoOro).
gano(mat_boy, granPremioCriadores).

% Punto 2: 2 puntos
masDeUnJockey(Caballo):-
  distinct(Caballo, (
    prefiere(Caballo, Jockey1),
    prefiere(Caballo, Jockey2),
    Jockey1 \= Jockey2
  )).

% Punto 3: 2 puntos
aborrece(Caballo, Stud):-
  stud(Stud),
  caballo(Caballo),
  not((prefiere(Caballo, Jockey), representa(Jockey, Stud))).

stud(Stud):-
  distinct(Stud, representa(_, Stud)).

% Punto 4: 2 puntos
premio_importante(granPremioNacional).
premio_importante(granPremioRepublica).

gano_premio_importante(Caballo):-
    gano(Caballo, Premio), 
    premio_importante(Premio).

piolin(Jockey):-
    jockey(Jockey, _, _), 
    forall(gano_premio_importante(Caballo), 
    prefiere(Caballo, Jockey)).


% Punto 5: El jugador
ganadora(ganador(Caballo), Resultado):-salioPrimero(Caballo, Resultado).
ganadora(segundo(Caballo), Resultado):-salioPrimero(Caballo, Resultado).
ganadora(segundo(Caballo), Resultado):-salioSegundo(Caballo, Resultado).
ganadora(exacta(Caballo1, Caballo2),Resultado):-salioPrimero(Caballo1, Resultado), salioSegundo(Caballo2, Resultado).
ganadora(imperfecta(Caballo1, Caballo2),Resultado):-salioPrimero(Caballo1, Resultado), salioSegundo(Caballo2, Resultado).
ganadora(imperfecta(Caballo1, Caballo2),Resultado):-salioPrimero(Caballo2, Resultado), salioSegundo(Caballo1, Resultado).

salioPrimero(Caballo, [Caballo|_]).
salioSegundo(Caballo, [_|[Caballo|_]]).

% Punto 6: Los colores
crin(botafogo, tordo).
crin(oldMan, alazan).
crin(energica, ratonero).
crin(matBoy, palomino).
crin(yatasto, pinto).

color(tordo, negro).
color(alazan, marron).
color(ratonero, gris).
color(ratonero, negro).
color(palomino, marron).
color(palomino, blanco).
color(pinto, blanco).
color(pinto, marron).

comprar(Color, Caballos):-
  findall(Caballo, (crin(Caballo, Crin), color(Crin, Color)), CaballosPosibles),
  combinar(CaballosPosibles, Caballos),
  Caballos \= [].

combinar([], []).
combinar([Caballo|CaballosPosibles], [Caballo|Caballos]):-combinar(CaballosPosibles, Caballos).
combinar([_|CaballosPosibles], Caballos):-combinar(CaballosPosibles, Caballos).
