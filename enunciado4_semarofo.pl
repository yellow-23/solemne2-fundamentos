% enunciado4_semaforo.pl
% Base de conocimiento: cruce peatonal para un robot

:- dynamic luz_peatonal/1.

% Hechos posibles:
% luz_peatonal(roja).
% luz_peatonal(verde).

puede_cruzar :-
    luz_peatonal(verde).

decision('Cruzar ahora, paso permitido.') :-
    puede_cruzar, !.

decision('No cruzar, esperar luz verde.') :-
    \+ puede_cruzar.
