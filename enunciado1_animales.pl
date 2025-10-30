:- dynamic respuesta/2.

animales([pescado, perro, gato, jirafa, oso]).

perfil(pescado, [acuatico, escamas, aletas, branquias, oviparo, ectotermico, sin_pelaje, sin_patas, no_vuela]).
perfil(perro,   [mamifero, domestico, terrestre, patas4, pelaje, omnivoro, canido, ladra, no_vuela, no_acuatico]).
perfil(gato,    [mamifero, domestico, terrestre, patas4, pelaje, carnivoro, felino, maulla, retrae_garras, nocturno, no_vuela, no_acuatico]).
perfil(jirafa,  [mamifero, terrestre, patas4, pelaje, herbivoro, cuello_largo, muy_alta, manchas, alcanza_altas_ramas, diurno, no_vuela, no_acuatico]).
perfil(oso,     [mamifero, terrestre, patas4, pelaje, omnivoro, ursido, plantigrado, hiberna, fuerte, salvaje_estricto, no_vuela, no_acuatico]).

texto_pregunta(acuatico,            'Vive principalmente en el agua?').
texto_pregunta(escamas,             'Tiene escamas?').
texto_pregunta(aletas,              'Tiene aletas?').
texto_pregunta(branquias,           'Respira por branquias?').
texto_pregunta(oviparo,             'Pone huevos (oviparo)?').
texto_pregunta(ectotermico,         'Es de sangre fria (ectotermico)?').
texto_pregunta(sin_pelaje,          'No tiene pelaje?').
texto_pregunta(sin_patas,           'No tiene patas?').
texto_pregunta(no_vuela,            'No puede volar?').
texto_pregunta(mamifero,            'Es mamifero?').
texto_pregunta(domestico,           'Es domestico o domesticable?').
texto_pregunta(terrestre,           'Vive principalmente en tierra?').
texto_pregunta(patas4,              'Tiene cuatro patas?').
texto_pregunta(pelaje,              'Tiene pelaje (pelo)?').
texto_pregunta(omnivoro,            'Come de todo (omnivoro)?').
texto_pregunta(canido,              'Pertenece a los canidos (perros, zorros)?').
texto_pregunta(ladra,               'Ladra habitualmente?').
texto_pregunta(carnivoro,           'Come principalmente carne (carnivoro)?').
texto_pregunta(felino,              'Pertenece a los felinos (gatos)?').
texto_pregunta(maulla,              'Maulla habitualmente?').
texto_pregunta(retrae_garras,       'Puede retraer las garras?').
texto_pregunta(nocturno,            'Es nocturno?').
texto_pregunta(herbivoro,           'Come principalmente plantas (herbivoro)?').
texto_pregunta(cuello_largo,        'Tiene el cuello muy largo?').
texto_pregunta(muy_alta,            'Es muy alta?').
texto_pregunta(manchas,             'Tiene manchas en el pelaje?').
texto_pregunta(alcanza_altas_ramas, 'Alcanza hojas altas en los arboles?').
texto_pregunta(diurno,              'Es diurno?').
texto_pregunta(ursido,              'Pertenece a la familia de los osos (Ursidae)?').
texto_pregunta(plantigrado,         'Camina apoyando toda la planta del pie (plantigrado)?').
texto_pregunta(hiberna,             'Hiberna en invierno?').
texto_pregunta(fuerte,              'Es notablemente fuerte?').
texto_pregunta(salvaje_estricto,    'Es estrictamente salvaje (no domesticado)?').
texto_pregunta(no_acuatico,         'No vive principalmente en el agua?').

inicio :-
    retractall(respuesta(_,_)),
    animales(Animales),
    identificar(Animales, Animal),
    format('El animal es: ~w~n', [Animal]).

identificar([Animal], Animal) :- !.
identificar(Animales, Animal) :-
    siguiente_atributo(Animales, Atributo),
    preguntar(Atributo, Respuesta),
    assertz(respuesta(Atributo, Respuesta)),
    filtrar_por_respuesta(Animales, Atributo, Respuesta, NuevaLista),
    identificar(NuevaLista, Animal).

siguiente_atributo(Animales, Atributo) :-
    member(Animal, Animales),
    perfil(Animal, ListaAtributos),
    member(Atributo, ListaAtributos),
    \+ respuesta(Atributo, _),
    !.

preguntar(Atributo, Respuesta) :-
    texto_pregunta(Atributo, Texto),
    leer_respuesta_valida(Texto, Respuesta).

leer_respuesta_valida(Texto, Respuesta) :-
    format('~w (SI/NO | S/N | Y/N): ', [Texto]),
    read_line_to_string(user_input, String),
    string_lower(String, StringLower),
    (   normalizar(StringLower, Respuesta)
    ->  true
    ;   format('Respuesta invalida. Por favor ingrese SI/NO, S/N, o Y/N.~n', []),
        leer_respuesta_valida(Texto, Respuesta)
    ).

normalizar(Str, si) :-
    member(Str, ["si", "s", "y", "yes"]).
normalizar(Str, no) :-
    member(Str, ["no", "n"]).

filtrar_por_respuesta([], _, _, []).
filtrar_por_respuesta([Animal|Resto], Atributo, si, [Animal|Filtrado]) :-
    perfil(Animal, Attrs),
    member(Atributo, Attrs),
    filtrar_por_respuesta(Resto, Atributo, si, Filtrado).
filtrar_por_respuesta([Animal|Resto], Atributo, si, Filtrado) :-
    perfil(Animal, Attrs),
    \+ member(Atributo, Attrs),
    filtrar_por_respuesta(Resto, Atributo, si, Filtrado).
filtrar_por_respuesta([Animal|Resto], Atributo, no, [Animal|Filtrado]) :-
    perfil(Animal, Attrs),
    \+ member(Atributo, Attrs),
    filtrar_por_respuesta(Resto, Atributo, no, Filtrado).
filtrar_por_respuesta([Animal|Resto], Atributo, no, Filtrado) :-
    perfil(Animal, Attrs),
    member(Atributo, Attrs),
    filtrar_por_respuesta(Resto, Atributo, no, Filtrado).
