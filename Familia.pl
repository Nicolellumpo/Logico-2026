padre(nora, mily).
padre(nora, victor).
padre(aldo, thiago).
padre(aldo, nicole).
padre(carlos, _ ).

edad(mily,50).
edad(victor, 45).
edad(thiago, 15).
edad(nicole, 22).

problematico(victor).

persona( Persona) :-  padre(Persona, _).

noTieneHijos(Persona) :-  
    persona(Persona),
    findall(Hijo, padre(Persona, Hijo), Hijos), length(Hijos, 0). 
/*  la regla lógica de una persona que no tiene hijos es  p ∧ ¬q, 
 donde p = es una persona, q = tiene hijos. Entonces conceptualmente es mejor escribirlo:  */
noTieneHijos2(Persona) :-  
    persona(Persona),        
    not(padre(Persona, _)). 


hijoUnico(Persona) :-  
    padre(Padre, Persona), 
    findall(Hijo, padre(Padre, Hijo), Hijos), 
    length(Hijos, 1).
/*es mejor decir que un hijo único es aquel que no tiene hermanos,
 o aquel cuyo padre no tiene otro hijo más que él: */
hijoUnico2(Persona) :-  
    padre(Padre, Persona), 
    not((padre(Padre, Persona2), Persona \= Persona2)). 


estaComplicado(Persona):-  
    findall(Hijo,  (padre(Persona, Hijo), edad(Hijo, Edad), Edad < 18),  Hijos), 
    member(Hijo, Hijos), 
    problematico(Hijo). 
/* Esto se pone en evidencia por el uso del findall seguido por un  member sobre la lista resultante. 
El findall arma listas, el member las desarma... ¡son operaciones inversas!  */
estaComplicado2(Persona):-  
    padre(Persona, Hijo),  
    edad(Hijo, Edad),  
    Edad < 18,  problematico(Hijo). 