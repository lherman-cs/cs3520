
distanceR2([], [], Dsq) :-
    Dsq is 0.

distanceR2([H1|T1],[H2|T2],Dsq) :-
    distanceR2(T1, T2, Rest),
    Dsq is Rest + (H1 - H2) * (H1 - H2).