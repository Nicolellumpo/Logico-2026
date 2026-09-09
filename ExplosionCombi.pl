% --------------------------------------------Ejemplo 1 -------------------------------------------------------------
actividad(cine). 
actividad(arjona). 
actividad(princesas_on_ice). 
actividad(pool). 
actividad(bowling).

costo(cine, 400). 
costo(arjona, 1750). 
costo(princesas_on_ice, 2500). 
costo(pool, 350). 
costo(bowling, 300). 

actividades(Plata, ActividadesPosibles):- 
    findall(Actividad, actividad(Actividad), Actividades), 
    actividadesPosibles(Actividades, Plata, ActividadesPosibles). 


actividadesPosibles([] , _ , []). 

actividadesPosibles([Actividad|Actividades], Plata, [Actividad|Posibles]):- 
    costo(Actividad, Costo),  
    Plata > Costo,  
    PlataRestante is Plata - Costo, 
    actividadesPosibles(Actividades, PlataRestante, Posibles). 

actividadesPosibles([_|Actividades], Plata, Posibles):- 
    actividadesPosibles(Actividades, Plata, Posibles). 


% --------------------------------------------Ejemplo 2 -------------------------------------------------------------
cocinero(donato). 
cocinero(pietro). 

pirata(felipe, 27). 
pirata(marcos, 39). 
pirata(facundo, 45). 
pirata(tomas, 20). 
pirata(betina, 26). 
pirata(gonzalo, 22). 

bravo(tomas). 
bravo(felipe). 
bravo(marcos).
bravo(betina). 

personasPosibles([donato, pietro, felipe, marcos, facundo, tomas, gonzalo, betina]). 

tripulacionBarco(Tripulacion):- 
    personasPosibles(Personas),
    tripulacion(Personas, Tripulacion).

tripulacion([], []). 
tripulacion([Posible|Posibles], [Posible|Tripulantes]):- 
    puedeSubirAlBarco(Posible),  
    tripulacion(Posibles, Tripulantes). 
tripulacion([_|Posibles], Tripulantes):- 
    tripulacion(Posibles, Tripulantes). 

puedeSubirAlBarco(Persona):- cocinero(Persona). 
puedeSubirAlBarco(Persona):- pirata(Persona, _), bravo(Persona). 
puedeSubirAlBarco(Persona):- pirata(Persona, Edad), Edad > 40. 