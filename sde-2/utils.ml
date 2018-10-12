open List;;
#use "helpers.ml";;

let rec distanceR2 = function
  ([], []) -> 0.
  | (v1, []) -> 0.
  | ([], v2) -> 0.
  | (h1::t1, h2::t2) -> ((h1 -. h2) ** 2.) +. distanceR2(t1, t2)

let rec distanceSqAllMeans = function
  (v, []) -> []
  | (v, h::t) -> distanceR2(v, h)::distanceSqAllMeans(v, t)

let listMinPos(alist) = find(alist, minElement(alist));;

let rec elsum = function
  ([], []) -> []
  | (v1, []) -> []
  | ([], v2) -> []
  | (h1::t1, h2::t2) -> (h1 +. h2)::elsum(t1, t2)

let rec scaleList = function
  ([], scale) -> []
  | (h::t, 0) -> h::t
  | (h::t, scale) -> (h /. float_of_int(scale))::scaleList(t, scale)

let rec zeroes = function
  0 -> []
  | size -> 0.::zeroes(size - 1)

let rec zeroMeansSet = function
  (0, d) -> []
  | (c, d) -> zeroes(d)::zeroMeansSet(c - 1, d)

let zeroVdiff(v1, v2) = v1 = v2;;

let rec zeroSetDiff = function
  ([], []) -> true
  | (s1, []) -> true
  | ([], s2) -> true
  | (h1::t1, h2::t2) -> zeroVdiff(h1, h2) && zeroSetDiff(t1, t2)

let rec zeroCounts = function
  0 -> []
  | size -> 0::zeroCounts(size - 1)

let rec updateCounts = function
  (p, []) -> []
  | (0, h::t) -> (h + 1)::t
  | (p, h::t) -> h::updateCounts(p - 1, t)

let rec updateMeansSum = function
  (v, x, []) -> []
  | (v, 0, mean::meansTail) -> elsum(v, mean)::meansTail
  | (v, x, mean::meansTail) ->  mean::updateMeansSum(v, x - 1, meansTail)

(* let rec formNewMeans = function *)


