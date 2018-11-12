distanceR2([], [], Dsq) :-
    Dsq = 0.

distanceR2([H1|T1], [H2|T2], Dsq) :-
    distanceR2(T1, T2, DsqRest),
    Dsq is DsqRest + (H1 - H2) * (H1 - H2).


distanceSqAllMeans(_, [], Dsq) :-
    Dsq = [].

distanceSqAllMeans(V, [VsetH|VsetT], Dsq) :-
    distanceSqAllMeans(V, VsetT, DsqRest),
    distanceR2(V, VsetH, DsqCur),
    append([DsqCur], DsqRest, Dsq).


findPos([], _, Pos) :-
    Pos = -1.

findPos([Val|T], Val, Pos) :-
    Pos = 0.

findPos([H|T], Val, Pos) :-
    findPos(T, Val, Pos1),
    Pos is Pos1 + 1.
