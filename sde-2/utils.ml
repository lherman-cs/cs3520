open List;;
#use "helpers.ml";;

let rec distanceR2 = function
  ([], []) | (_, []) | ([], _) -> 0.
  | (h1::t1, h2::t2) -> ((h1 -. h2) ** 2.) +. distanceR2(t1, t2)

let rec distanceSqAllMeans = function
  (v, []) -> []
  | (v, h::t) -> distanceR2(v, h)::distanceSqAllMeans(v, t)

let listMinPos(alist) = find(alist, minElement(alist));;

let rec elsum = function
  ([], []) | (_, []) | ([], _) -> []
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

let rec _zeroVdiff = function
  ([], [], last) | (_, [], last) | ([], _, last) -> last
  | (_, _, false) -> false
  | (h1::t1, h2::t2, last) -> _zeroVdiff(t1, t2, (last && (h1 = h2)))
let zeroVdiff(s1, s2) = _zeroVdiff(s1, s2, true);;;;

let rec _zeroSetDiff = function
  ([], [], last) | (_, [], last) | ([], _, last) -> last
  | (_, _, false) -> false
  | (h1::t1, h2::t2, last) -> _zeroSetDiff(t1, t2, (last && zeroVdiff(h1, h2)))
let zeroSetDiff(s1, s2) = _zeroSetDiff(s1, s2, true);;

let rec zeroCounts = function
  0 -> []
  | size -> 0::zeroCounts(size - 1)

let rec updateCounts = function
  (p, []) -> []
  | (0, h::t) -> (h + 1)::t
  | (p, h::t) -> h::updateCounts(p - 1, t)

let rec updateMeansSum = function
  (v, x, []) -> []
  | (v, 0, h::t) -> elsum(v, h)::t
  | (v, x, h::t) ->  h::updateMeansSum(v, x - 1, t)

let rec formNewMeans = function
  ([], []) | (_, []) | ([], _) -> []
  | (h1::t1, h2::t2) -> scaleList(h1, h2)::formNewMeans(t1, t2)


let nearestMean(h, means) = listMinPos(distanceSqAllMeans(h, means));;

let rec reclassify = function
  (* update te newMeansSum and newCounts and move the currMeans *)
  ([], currMeans, newMeansSum, newCounts) -> formNewMeans(newMeansSum, newCounts)
  
  (* Recurse each point *)
  | (h::t, currMeans, newMeansSum, newCounts) -> 
    reclassify(
      t, 
      currMeans, 
      updateMeansSum(h, nearestMean(h, currMeans), newMeansSum), 
      updateCounts(nearestMean(h, currMeans), newCounts)
    )


let reclassifyPartial(c, h, means) = reclassify(h, means, zeroMeansSet(c, (length (hd h))), zeroCounts(c));; 

let rec cmeans = function
  (c, h, currMeans) when zeroSetDiff(reclassifyPartial(c, h, currMeans), currMeans) -> currMeans
  | (c, h, currMeans) -> cmeans(c, h, reclassifyPartial(c, h, currMeans))