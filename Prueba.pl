% Hechos
tiene_pelo(perro).
tiene_pelo(gato).
tiene_pelo(vaca).

pone_huevos(serpiente).
pone_huevos(aguila).

vuela(aguila).
vuela(murcielago).

mamifero(perro).
mamifero(gato).
mamifero(murcielago).
mamifero(vaca).

% Reglas
es_ave(Animal) :- pone_huevos(Animal), vuela(Animal).
reptil(Animal) :- pone_huevos(Animal), \+ vuela(Animal).
es_mamifero(Animal) :- tiene_pelo(Animal), mamifero(Animal).

% Consultas de ejemplo:
% ? es_ave(aguila).
% ? es_reptil(serpiente).
% ? es_mamifero(perro).
