consult('cmeans.pro').

distanceR2([1, 2], [2, 3], What).
distanceR2([1], [3], What).
distanceR2([3,3,3], [3,3,3], What).

distanceSqAllMeans([1,2,3], [[1,2,3],[4,5,6]], What).
distanceSqAllMeans([2,2,3], [[3,2,1],[4,5,6]], What).
distanceSqAllMeans([2,2,3], [[3,2,1],[4,5,6],[1,1,1]], What).

listMinPos([1,2,3,4], What).
listMinPos([3,3,3], What).
listMinPos([9,1,1], What).

elsum([1,2,3], [1,2,3], What).
elsum([1,2,3], [3,2,1], What).
elsum([-1,-2,-3], [3,2,1], What).

scaleList([1,2,3,4,5], 0, What).
scaleList([1,2,3,4,5], 1, What).
scaleList([1,2,3,4,5], 2, What).

zeroes(30, What).
zeroes(10, What).
zeroes(0, What).

zeroMeansSet(4, 3, What).
zeroMeansSet(1, 1, What).
zeroMeansSet(1, 10, What).

zeroVdiff([1,2,3], [1,2,3]).
zeroVdiff([1,2], [2,1]).
zeroVdiff([1], [1]).

zeroSetDiff([[1,2], [2,3]], [[1,2], [2,3]]).
zeroSetDiff([[1,2], [2,2]], [[1,2], [2,2]]).
zeroSetDiff([[1,1], [1,1]], [[1,1], [1,1]]).

zeroCounts(30, What).
zeroCounts(10, What).
zeroCounts(0, What).

updateCounts(2, [1,2,3], What).
updateCounts(1, [1,2,3], What).
updateCounts(0, [1,2,3], What).

zeroMeansSet(4, 4, M),
updateMeansSum([1.0, 3.0, 2.0, 4.0], 0, M, What).
zeroMeansSet(6, 2, M),
updateMeansSum([1.0, 3.0], 2, M, What).
zeroMeansSet(3, 2, M),
updateMeansSum([1.0, 3.0], 0, M, What).

formNewMeans([[99, 33], [0, 0]], [3, 3], What).
formNewMeans([[99, 33], [0, 0]], [0, 0], What).
formNewMeans([[99], [33], [3]], [3, 3, 3], What).

reclassify([[1,2,3], [3,4,5]], [[1,2,3], [3,4,5]], What).
reclassify([[1,2,3], [3,4,5]], [[1,2,2], [4,4,5]], What).
reclassify([[1,2,3], [3,4,5]], [[4,4,2], [1,1,1]], What).

cmeans([[1,1], [1,3], [3,1], [10,3], [9,1]], [[1,1], [7,1]], What).
cmeans([[1,1], [1,3], [3,1], [10,3], [9,1]], [[4,4], [5,5]], What).
cmeans([[1,1], [1,3], [3,1], [10,3], [9,1]], [[-300,-200], [9999,999]], What).