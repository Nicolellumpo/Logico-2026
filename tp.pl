% ===========================================================================
%                            Base de conocimiento
% ===========================================================================
% Punto 1 y 5 (Grupal)

% tipoDisciplina(Disciplina, Tipo).
tipoDisciplina(jiu_jitsu, piso).
tipoDisciplina(sambo, piso).
tipoDisciplina(judo, piso).

tipoDisciplina(muay_thai, parado).
tipoDisciplina(boxeo, parado).
tipoDisciplina(kickboxing, parado).

%luchador(Luchador).
luchador(mora).	
luchador(tomi).
luchador(vale).
luchador(mati).
luchador(facu).
luchador(fede).

%disciplina (Luchador, Disciplina)
disciplina(mora, jiu_jitsu).
disciplina(mora, muay_thai).

disciplina(tomi, muay_thai).
disciplina(tomi, boxeo).

disciplina(vale, judo).
disciplina(vale, kickboxing).

disciplina(mati, sambo).

disciplina(facu, muay_thai).
disciplina(facu, boxeo).
disciplina(facu, kickboxing).

% fede no entrena ninguna disciplina por ende no esta en la base de conocimiento por universo cerrado

%cinturon(Luchador, Disciplina, Color).
cinturon(mora, jiu_jitsu, violeta).
cinturon(vale, judo, marron).
cinturon(mati, sambo, negro).

%tecnica(Luchador, Tipo(ataque,posicion),efectividad)
tecnica(mora, piso(triangulo,guardia),4).
tecnica(mora, piso(armlock,montada),7).
tecnica(mora, paradoGolpe(rodillazo,cuerpo),6).
tecnica(mora, paradoGolpe(patada,cabeza),8).

tecnica(tomi, paradoGolpe(codazo, cabeza),9).
tecnica(tomi, paradoGolpe(gancho,cabeza),6).
tecnica(tomi, paradoGolpe(directo,cuerpo),7).
tecnica(tomi, piso(mataleon,espalda),8).

tecnica(vale, piso(estrangulacion,espalda),3).
tecnica(vale, paradoGolpe(patada,pierna),7).
tecnica(vale, paradoGolpe(cruzado,cabeza),9).
tecnica(vale, paradoLance(oSotoGari,proyeccion),9).
tecnica(vale, paradoLance(ipponSeoiNage,tacle),6).

tecnica(mati, piso(botita,guardia),3).
tecnica(mati, piso(triangulo,guardia),4).
tecnica(mati, piso(mataleon,espalda),5).
tecnica(mati, piso(llaveBrazo,espalda),2).
tecnica(mati, piso(llaveBrazo,montada),4).
tecnica(mati, piso(llaveRodilla,montada),5).	

tecnica(facu,paradoGolpe(directo,cabeza),9).
tecnica(facu,paradoGolpe(gancho,cabeza),8).
tecnica(facu,paradoGolpe(patada,cabeza),10).

esEquivalente(cinturon(Luchador, judo, negro)) :- cinturon(Luchador, jiu_jitsu, violeta).

% Punto 2 (Integrante 1)
esFielASuDisciplina(Luchador) :-
	luchador(Luchador),
	forall(tecnica(Luchador, Tecnica , _),
		  (tipoTecnica(Tecnica, Tipo),
		  entrenaTipo(Luchador, Tipo))).

tipoTecnica(piso(_,_), piso).
tipoTecnica(paradoGolpe(_,_), parado).
tipoTecnica(paradoLance(_,_), parado).

entrenaTipo(Luchador, Tipo) :-
    disciplina(Luchador, Disciplina),
    tipoDisciplina(Disciplina, Tipo).

% Punto 3 (Integrante 2)
esPicante(Luchador):-
	luchador(Luchador),
	entrenaTipo(Luchador,parado),
	not(entrenaTipo(Luchador,piso)),
	forall(tecnica(Luchador, Tipo, _), golpeACabeza(Tipo)).

golpeACabeza(paradoGolpe(_, cabeza)).

% Punto 4 (Integrante 3)
esNavajaSuiza(Luchador) :-
	luchador(Luchador),
	tieneCinturonNegro(Luchador),
	mismoSometimiento(Luchador),
	not(entrenaTipo(Luchador, parado)).

 tieneCinturonNegro(Luchador) :-
 	cinturon(Luchador, _, negro).
 tieneCinturonNegro(Luchador) :-
 	esEquivalente(cinturon(Luchador, _, negro)).

mismoSometimiento(Luchador) :-
    tecnica(Luchador, piso(Sometimiento, UnaPosicion),_),
    tecnica(Luchador, piso(Sometimiento, OtraPosicion),_),
    UnaPosicion \= OtraPosicion.

% Punto 5 (Grupal)
esContundente(tecnica(_, piso(_, _), Efectividad)) :- tecnica(_, piso(_, _), Efectividad) ,Efectividad =< 5.
esContundente(tecnica(_, paradoGolpe(_, cabeza), Potencia)) :- tecnica(_, paradoGolpe(_, cabeza), Potencia) , Potencia >= 8.
esContundente(tecnica(_, paradoLance(_, _), Puntos)) :-  tecnica(_, paradoLance(_, _), Puntos), Puntos >= 8.

% Punto 6 (Integrante 1)
tieneUnPuntoFlojo(Luchador) :-
	luchador(Luchador),
	tecnica(Luchador, piso(Nombre, Posicion), Efectividad),
	not(esContundente(tecnica(Luchador, piso(Nombre, Posicion), Efectividad))).

% Punto 7 (Integrante 2)
esCertero(Luchador):-
	tecnica(Luchador,_,_),
	forall((tecnica(Luchador,TipoParado,Efectividad),
	(esContundente(tecnica(Luchador,TipoParado, Efectividad)))), 
	esDeParado(TipoParado)).

esDeParado(paradoGolpe(_,_)).
esDeParado(paradoLance(_,_)).

% Punto 8 (Integrante 3)
esTemible(Luchador) :-
	tecnica(Luchador, _, _),
	forall(tecnica(Luchador, Tipo, Efectividad), esContundente(tecnica(Luchador, Tipo, Efectividad))).

% Punto 9 (Grupal)
comboPosible(Luchador, CantidadMaxima,Combo) :- 
	luchador(Luchador),
	findall(Tecnica, tecnica(Luchador, Tecnica, _), Tecnicas),
	facilitarCombos(Tecnicas, Combo),
	length(Combo, Cantidad),
	Cantidad =< CantidadMaxima.
	
facilitarCombos([], []). % caso Base
facilitarCombos([_Tecnica|Resto], Combo) :- facilitarCombos(Resto, Combo). % caso Recursivo
facilitarCombos([Tecnica|Resto], [Tecnica|Combo]) :- facilitarCombos(Resto, Combo). % caso Recursivo
	
:- begin_tests(template).

% 2. esFielASuDisciplina
test(vale_es_fiel_a_su_disciplina, nondet):- esFielASuDisciplina(vale).
test(tomi_no_es_fiel_a_su_disciplina, fail):- esFielASuDisciplina(tomi).
test(esFielASuDisciplina_es_inversible , set(Luchador == [facu, fede, mati, mora, vale])) :- esFielASuDisciplina(Luchador).

% 3. esPicante
test(facu_es_picante,nondet):- esPicante(facu).
test(tomi_no_es_picante,fail):- esPicante(tomi).
test(mora_no_es_picante,fail):- esPicante(mora).
test(vale_no_es_picante,fail):- esPicante(vale).
test(esPicante_es_inversible, set(Luchador == [facu])):- esPicante(Luchador).
	
% 4. esNavajaSuiza
test(esNavajaSuiza_es_inversible, set(Luchador == [mati])) :- esNavajaSuiza(Luchador).
test(mati_es_navaja_suiza, nondet) :- esNavajaSuiza(mati).
test(mora_no_es_navaja_suiza, fail) :- esNavajaSuiza(mora).

% 5. esContundente
test(triangulo_de_mora_es_contundente, nondet):- esContundente(tecnica(_, piso(triangulo,guardia), 4)).
test(armlock_de_mora_no_es_contundente, fail):- esContundente(tecnica(_, piso(armlock,montada), 7)).
test(patada_de_mora_es_contundente, nondet):- esContundente(tecnica(_, paradoGolpe(patada,cabeza), 9)).
test(rodillazo_de_mora_no_es_contundente, fail):- esContundente(tecnica(_, paradoGolpe(rodillazo,cuerpo), 9)).
test(gancho_de_tomi_no_es_contundente, fail):- esContundente(tecnica(_, paradoGolpe(gancho,cabeza), 6)).
test(oSotoGari_de_vale_es_contundente, nondet):- esContundente(tecnica(_, paradoLance(oSotoGari,proyeccion), 9)).
test(ipponSeoiNage_de_vale_no_es_contundente, fail):- esContundente(tecnica(_, paradoLance(ipponSeoiNage,tacle), 6)).

% 6. tieneUnPuntoFlojo
test(mora_tiene_punto_flojo, nondet):-  tieneUnPuntoFlojo(mora).
test(tomi_tiene_punto_flojo, nondet):-  tieneUnPuntoFlojo(tomi).
test(vale_no_tiene_punto_flojo, fail):- tieneUnPuntoFlojo(vale).
test(mati_no_tiene_punto_flojo, fail):- tieneUnPuntoFlojo(mati).
test(facu_no_tiene_punto_flojo, fail):- tieneUnPuntoFlojo(facu).
test(tieneUnPuntoFlojo_inversible, set(Flojos == [mora, tomi])):- tieneUnPuntoFlojo(Flojos).

% 7. esCertero
test(tomi_es_certero,nondet):- esCertero(tomi).
test(facu_es_certero,nondet):- esCertero(facu).
test(mora_es_certero,fail):-   esCertero(mora).
test(vale_es_certero,fail):-   esCertero(vale).
test(mati_es_certero,fail):-   esCertero(mati).
test(esCertero_es_inversible, set(Luchador == [tomi,facu])):- esCertero(Luchador).

% 8. esTemible
test(mati_es_temible, nondet):- esTemible(mati).
test(facu_es_temible, nondet):- esTemible(facu).
test(mora_no_es_temible, fail):- esTemible(mora).
test(tomi_no_es_temible, fail):- esTemible(tomi).
test(vale_no_es_temible, fail):- esTemible(vale).
test(esTemible_es_inversible, set(Luchador == [facu, mati])):- esTemible(Luchador).

% 9. comboPosible
test(facu_4_combos_hasta_1):-
    findall(Combo, comboPosible(facu, 1, Combo), Combos), length(Combos, 4).
test(facu_7_combos_hasta_2):-
    findall(Combo, comboPosible(facu, 2, Combo), Combos), length(Combos, 7).
test(facu_8_combos_hasta_3):-
    findall(Combo, comboPosible(facu, 3, Combo), Combos), length(Combos, 8).
test(mati_22_combos_hasta_2):-
    findall(Combo, comboPosible(mati, 2, Combo), Combos), length(Combos, 22).
test(mati_maximo_0_solo_el_combo_vacio):-
    findall(Combo, comboPosible(mati, 0, Combo), Combos), Combos == [[]].
test(comboPosible_es_inversible_para_el_combo):-
    once(comboPosible(facu, 0, [])).

:- end_tests(template).