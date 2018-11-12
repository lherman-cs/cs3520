
:- begin_tests('cmeans').
:- use_module(library(lists)).
:- consult('cmeans.pro').
:- consult('inputs.pro').
:- consult('inputs2.pro').

test(distanceR2) :- distanceR2([1,2,3], [2,3,4], Dist), assertion(Dist == 3).

test(distanceSqAllMeans) :- 
    h(ts1,H),nth0(0,H,First),once(distanceSqAllMeans(First,H,What)),
    assertion(What == [0.0, 20127.571445602007, 1097.1155359600039, 24526.929309464005, 95.23227815000496, 22472.373665942006, 332.92734064000405, 17537.187875314]).

test(distanceSqAllMeans) :-
     h(ts1,H),nth0(2,H,Third),once(distanceSqAllMeans(Third,H,What)),
     assertion(What == [1097.1155359600039, 14020.845778464001, 0.0, 17759.913254007995, 556.8904418160012, 15656.090539912002, 1137.0370000000003, 11788.743942900004]).

test(distanceSqAllMeans) :-
     h(ts1,H),last(H,Last),once(distanceSqAllMeans(Last,H,What)),
     assertion(What ==  [17537.187875314, 98.11331742600892, 11788.743942900004, 610.0996143500097, 15352.842032220007, 319.912766108008, 14023.895548400005, 0.0]).

:- end_tests('cmeans').
:- run_tests.