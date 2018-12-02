distanceR2([], [], 0).
distanceR2([H1|T1], [H2|T2], Dsq) :-
    distanceR2(T1, T2, DsqRest),
    Dsq is DsqRest+(H1-H2)*(H1-H2).


distanceSqAllMeans(_, [], []).
distanceSqAllMeans(V, [VsetH|VsetT], Dsq) :-
    distanceSqAllMeans(V, VsetT, DsqRest),
    distanceR2(V, VsetH, DsqCur),
    Dsq=[DsqCur|DsqRest].


findPos([], _, -1).
findPos([Val|_], Val, 0).
findPos([_|T], Val, Pos) :-
    findPos(T, Val, Pos1),
    Pos is Pos1+1.


listMin([X], X).
listMin([X, Y|T], Min) :-
    X=<Y,
    listMin([X|T], Min).
listMin([X, Y|T], Min) :-
    X>Y,
    listMin([Y|T], Min).


listMinPos([], -1).
listMinPos(List, Pos) :-
    listMin(List, Min),
    findPos(List, Min, Pos).


elsum([], [], []).
elsum([H1|T1], [H2|T2], S) :-
    elsum(T1, T2, Rest),
    Sum is H1+H2,
    append([Sum], Rest, S).


scaleList([], _, []).
scaleList(H, 0, H).
scaleList([H|T], Scale, Answer) :-
    scaleList(T, Scale, Rest),
    Scaled is H/Scale,
    Answer=[Scaled|Rest].
