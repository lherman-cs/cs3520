:- begin_tests(cmeans).
:- use_module(library(lists)).
:- consult('cmeans.pro').
:- consult('inputs.pro').
:- consult('inputs2.pro').

test(distanceR2) :-
    distanceR2([1, 2, 3], [2, 3, 4], Dist),
    assertion(Dist==3).

test(distanceSqAllMeans) :-
    h(ts1, H),
    nth0(0, H, First),
    once(distanceSqAllMeans(First, H, What)),
    assertion(What==[0.0, 20127.571445602007, 1097.1155359600039, 24526.929309464005, 95.23227815000496, 22472.373665942006, 332.92734064000405, 17537.187875314]).

test(distanceSqAllMeans) :-
    h(ts1, H),
    nth0(2, H, Third),
    once(distanceSqAllMeans(Third, H, What)),
    assertion(What==[1097.1155359600039, 14020.845778464001, 0.0, 17759.913254007995, 556.8904418160012, 15656.090539912002, 1137.0370000000003, 11788.743942900004]).

test(distanceSqAllMeans) :-
    h(ts1, H),
    last(H, Last),
    once(distanceSqAllMeans(Last, H, What)),
    assertion(What==[17537.187875314, 98.11331742600892, 11788.743942900004, 610.0996143500097, 15352.842032220007, 319.912766108008, 14023.895548400005, 0.0]).

test(findPos) :-
    once(findPos([1, 2, 3, 4], 3, Pos)),
    assertion(Pos==2).

test(listMin) :-
    once(listMin([1, 2, 3], Min)),
    assertion(Min==1).

test(listMin) :-
    once(listMin([1, 2], Min)),
    assertion(Min==1).

test(listMinPos) :-
    h(ts1, H),
    nth0(0, H, First),
    once(distanceSqAllMeans(First, H, Dists)),
    once(listMin(Dists, What)),
    assertion(What==0.0).

test(listMinPos) :-
    h(ts1, H),
    nth0(2, H, Third),
    once(distanceSqAllMeans(Third, H, Dists)),
    once(listMin(Dists, What)),
    assertion(What==0.0).

test(listMinPos) :-
    h(ts1, H),
    nth0(0, H, First),
    once(distanceSqAllMeans(First, H, Dists)),
    once(listMinPos(Dists, Where)),
    assertion(Where==0).

test(listMinPos) :-
    h(ts1, H),
    nth0(2, H, Third),
    once(distanceSqAllMeans(Third, H, Dists)),
    once(listMinPos(Dists, Where)),
    assertion(Where==2).

test(elsum) :-
    once(elsum([1.0, 2.0, 3.0, 4.0], [6.0, 7.0, 8.0, 9.0], Answer)),
    assertion(Answer==[7.0, 9.0, 11.0, 13.0]).

test(scaleList) :-
    once(scaleList([1.0, 2.0, 3.0], 10, Result)),
    assertion(Result==[0.1, 0.2, 0.3]).

test(scaleList) :-
    once(scaleList([1.0, 2.0, 3.0], 0, Answer)),
    assertion(Answer==[1.0, 2.0, 3.0]).

test(zeroes) :-
    once(zeroes(6, Alist)),
    assertion(Alist=[0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).

test(zeroMeansSet) :-
    once(zeroMeansSet(4, 5, TheSet)),
    assertion(TheSet==[[0.0, 0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0, 0.0]]).

test(zeroVdiff) :-
    once(\+zeroVdiff([1, 2, 3, 4], [4, 3, 2, 1])).

test(zeroVdiff) :-
    once(zeroVdiff([1, 2, 3, 4], [1, 2, 3, 4])).

test(zeroSetDiff) :-
    once(\+zeroSetDiff([[1, 2, 3], [1, 2, 4]], [[1, 2, 3], [1, 2, 3]])).

test(zeroSetDiff) :-
    once(zeroSetDiff([[1, 2, 3], [1, 2, 3]], [[1, 2, 3], [1, 2, 3]])).

test(zeroCounts) :-
    once(zeroCounts(8, Out)),
    assertion(Out==[0, 0, 0, 0, 0, 0, 0, 0]).

test(updateCounts) :-
    once(zeroCounts(6, S)),
    once(updateCounts(0, S, Updated)),
    assertion(Updated==[1, 0, 0, 0, 0, 0]).

test(updateCounts) :-
    once(zeroCounts(6, S)),
    once(updateCounts(3, S, Updated)),
    assertion(Updated==[0, 0, 0, 1, 0, 0]).

test(updateCounts) :-
    once(zeroCounts(6, S)),
    once(updateCounts(3, S, Updated)),
    once(updateCounts(3, Updated, Overall)),
    assertion(Overall==[0, 0, 0, 2, 0, 0]).

test(updateCounts) :-
    once(zeroCounts(6, S)),
    once(updateCounts(3, S, Updated)),
    once(updateCounts(3, Updated, Overall)),
    once(updateCounts(0, Overall, Overall2)),
    assertion(Overall2==[1, 0, 0, 2, 0, 0]).

test(updateMeansSum) :-
    once(zeroMeansSet(4, 3, M)),
    once(updateMeansSum([1.0, 2.0, 3.0], 0, M, Result)),
    assertion(Result==[[1.0, 2.0, 3.0], [0.0, 0.0, 0.0], [0.0, 0.0, 0.0], [0.0, 0.0, 0.0]]).

test(updateMeansSum) :-
    once(zeroMeansSet(4, 3, M)),
    once(updateMeansSum([1.0, 2.0, 3.0], 2, M, Result)),
    assertion(Result==[[0.0, 0.0, 0.0], [0.0, 0.0, 0.0], [1.0, 2.0, 3.0], [0.0, 0.0, 0.0]]).

test(formNewMeans) :-
    once(formNewMeans([[100.5], [-29.1]], [3, 5], NewMeans)),
    assertion(NewMeans==[[33.5], [-5.82]]).

test(reclassify) :-
    h(ts2, H),
    once(reclassify(H, [[1.0, 1.0], [-1.0, -2.0]], NewMu)),
    assertion(NewMu==[[47.698002, 62.48], [-49.005001, -41.327999]]).

test(reclassify) :-
    h(ts2, H),
    once(reclassify(H, [[1.0, 1.0], [-1.0, -2.0]], NewMu)),
    once(reclassify(H, NewMu, Mu2)),
    assertion(Mu2==[[47.698002, 62.48], [-49.005001, -41.327999]]).

test(reclassify) :-
    h(ts2, H),
    once(reclassify(H, [[1.0, 1.0], [-1.0, -2.0]], NewMu)),
    once(reclassify(H, NewMu, Mu2)),
    once(reclassify(H, Mu2, Mu3)),
    assertion(Mu3==[[47.698002, 62.48], [-49.005001, -41.327999]]).

test(reclassify) :-
    bigH(H),
    muzero(MZ0),
    once(reclassify(H, MZ0, Mu1)),
    assertion(Mu1==[[7.09669729142857, 6.978222742857141], [-59.76440036000001, -62.452799840000004]]).

test(reclassify) :-
    bigH(H),
    muzero(MZ0),
    once(reclassify(H, MZ0, Mu1)),
    once(reclassify(H, Mu1, Mu2)),
    assertion(Mu2==[[48.58256020000002, 49.11889989000001], [-51.10444003, -52.52021005]]).

test(reclassify) :-
    bigH(H),
    muzero(MZ0),
    once(reclassify(H, MZ0, Mu1)),
    once(reclassify(H, Mu1, Mu2)),
    once(reclassify(H, Mu2, Mu3)),
    assertion(Mu3==[[48.58256020000002, 49.11889989000001], [-51.10444003, -52.52021005]]).

test(reclassify) :-
    bigH(H),
    muzero(MZ0),
    once(reclassify(H, MZ0, Mu1)),
    once(reclassify(H, Mu1, Mu2)),
    once(reclassify(H, Mu2, Mu3)),
    once(reclassify(H, Mu3, Mu4)),
    assertion(Mu4==[[48.58256020000002, 49.11889989000001], [-51.10444003, -52.52021005]]).

test(cmeans) :-
    h(ts1, H),
    once(cmeans(H, [[1.0, 1.0], [-1.0, -2.0]], MuFinal)),
    assertion(MuFinal==[[42.2117505, 50.967749749999996], [-49.7515, -45.11149975]]).

test(cmeans) :-
    h(ts2, H),
    cmeans(H, [[1.0, 1.0], [-1.0, -2.0]], MuFinal),
    assertion(MuFinal==[[47.698002, 62.48], [-49.005001, -41.327999]]).

test(cmeans) :-
    bigH(H),
    muzero(MZ0),
    cmeans(H, MZ0, MuFinal),
    assertion(MuFinal==[[48.58256020000002, 49.11889989000001], [-51.10444003, -52.52021005]]).

:- end_tests(cmeans).
:- run_tests.