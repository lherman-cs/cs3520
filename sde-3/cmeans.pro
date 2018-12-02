distanceR2([], [], 0).
distanceR2([H1|T1], [H2|T2], Dsq) :-
    distanceR2(T1, T2, DsqRest),
    Dsq is DsqRest+(H1-H2)*(H1-H2).


distanceSqAllMeans(_, [], []).
distanceSqAllMeans(V, [VsetH|VsetT], [DsqCur|DsqRest]) :-
    distanceSqAllMeans(V, VsetT, DsqRest),
    distanceR2(V, VsetH, DsqCur).


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
elsum([H1|T1], [H2|T2], [H3|T3]) :-
    H3 is H1+H2,
    elsum(T1, T2, T3).


scaleList([], _, []).
scaleList(H1, 0, H2) :- !,
    H2=H1.
scaleList([H|T], Scale, [Scaled|Rest]) :-
    scaleList(T, Scale, Rest),
    Scaled is H/Scale.


zeroes(0, []).
zeroes(Size, []) :-
    Size<0.
zeroes(Size, [0.0|Rest]) :-
    RestSize is Size-1,
    zeroes(RestSize, Rest).


zeroMeansSet(0, _, []).
zeroMeansSet(Cmeans, Dim, [Vector|RestSet]) :-
    RestCmeans is Cmeans-1,
    zeroMeansSet(RestCmeans, Dim, RestSet),
    zeroes(Dim, Vector).


zeroVdiff([], []).
zeroVdiff([H|T1], [H|T2]) :-
    zeroVdiff(T1, T2).


zeroSetDiff([], []).
zeroSetDiff([H1|T1], [H2|T2]) :-
    zeroVdiff(H1, H2),
    zeroSetDiff(T1, T2).


zeroCounts(0, []).
zeroCounts(C, []) :-
    C<0.
zeroCounts(C, [0|T]) :-
    RestC is C-1,
    zeroCounts(RestC, T).


updateCounts(0, [H1|T], [H2|T]) :-
    H2 is H1+1.
updateCounts(P, [H|T1], [H|T2]) :-
    RestP is P-1,
    updateCounts(RestP, T1, T2).


updateMeansSum(V, 0, [H1|T], [H2|T]) :-
    elsum(V, H1, H2).
updateMeansSum(V, X, [H|T1], [H|T2]) :-
    RestX is X-1,
    updateMeansSum(V, RestX, T1, T2).


formNewMeans([], [], []).
formNewMeans([H1|T1], [H2|T2], [H3|T3]) :-
    scaleList(H1, H2, H3),
    formNewMeans(T1, T2, T3).


nearestMean(H, Means, Pos) :-
    distanceSqAllMeans(H, Means, Distances),
    listMinPos(Distances, Pos).

reclassifyHelper([], _, NewMeansSum, NewCounts, UpdatedMeans) :-
    formNewMeans(NewMeansSum, NewCounts, UpdatedMeans).

reclassifyHelper([H|T], CurrMeans, NewMeansSum, NewCounts, UpdatedMeans) :-
    nearestMean(H, CurrMeans, NearestPos),
    updateMeansSum(H, NearestPos, NewMeansSum, UpdatedNewMeansSum),
    updateCounts(NearestPos, NewCounts, UpdatedNewCounts),
    reclassifyHelper(T, CurrMeans, UpdatedNewMeansSum, UpdatedNewCounts, UpdatedMeans).

reclassify(H, CurrMeans, UpdatedMeans) :-
    nth0(0, CurrMeans, V),
    length(V, Dim),
    length(CurrMeans, Cmeans),
    zeroMeansSet(Cmeans, Dim, InitNewMeansSum),
    zeroCounts(Cmeans, InitNewCounts),
    reclassifyHelper(H, CurrMeans, InitNewMeansSum, InitNewCounts, UpdatedMeans).


cmeans(H, MuCurrent, MuFinal) :-
    reclassify(H, MuCurrent, UpdatedMu),
    zeroSetDiff(MuCurrent, UpdatedMu),
    MuFinal=UpdatedMu.

cmeans(H, MuCurrent, MuFinal) :-
    reclassify(H, MuCurrent, UpdatedMu),
    cmeans(H, UpdatedMu, MuFinal).
