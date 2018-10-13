open List;;
#use "utils.ml";;

(* Test distanceR2 *)
let v1 = [1.0;2.0;3.0];;
let v2 = [3.0;2.0;1.0];;
assert(distanceR2(v1, v2) = 8.);;

let v3 = [1.0;1.0;1.0];;
assert(distanceR2(v1, v3) = 5.);;

(* Test distanceSqAllMeans *)
let h = [
  [47.698002; 62.48]; [-49.005001; -41.327999]; [45.958; 29.403];
  [-60.546001; -50.702]; [45.403; 52.994999]; [-49.021; -52.053001];
  [29.788; 58.993]; [-40.433998; -36.362999]; [30.247; 46.307999]
];;
let testv = nth h 2;;

let expected = [
  1097.11553596000385; 
  14020.8457784640013; 
  0.; 
  17759.9132540079954;
  556.890441816001157; 
  15656.090539912002; 
  1137.03700000000026;
  11788.7439429000042; 
  532.614512190001;
];;
assert(distanceSqAllMeans(testv, h) = expected);;

(* listMinPos *)
assert(listMinPos(distanceSqAllMeans(testv, h)) = 2);;

(* elsum *)
assert(elsum ([1.0; 2.0; 3.0; 4.0;],[6.0; 7.0; 8.0; 9.0;]) = [7.; 9.; 11.; 13.]);;

(* scaleList *)
assert(scaleList([1.0;2.0;3.0], 10) = [0.1; 0.2; 0.3]);;
assert(scaleList([1.0;2.0;3.0],0) = [1.; 2.; 3.]);;

(* zeroes *)
assert(zeroes(10) = [0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.]);
assert(zeroes(2) = [0.; 0.])

(* zeroMeansSet *)
let expected = [
  [0.; 0.; 0.; 0.; 0.];
  [0.; 0.; 0.; 0.; 0.];
  [0.; 0.; 0.; 0.; 0.];
  [0.; 0.; 0.; 0.; 0.];
];;
assert(zeroMeansSet(4, 5) = expected);;

(* zeroVdiff *)
assert(zeroVdiff([1.0;2.0;3.0],[1.0;2.0;3.0]) = true);;
assert(zeroVdiff([1.0;2.0;3.0],[1.0;0.0;3.0]) = false);;

(* zeroSetDiff *)
assert(zeroSetDiff([[1;2;3];[1;2;4]],[[1;2;3];[1;2;3]]) = false);;
assert(zeroSetDiff([[1;2;3];[1;2;3]],[[1;2;3];[1;2;3]]) = true);;

(* zeroCounts *)
assert(zeroCounts(6) = [0; 0; 0; 0; 0; 0]);;

(* updateCounts *)
assert(updateCounts(3,zeroCounts(6)) = [0; 0; 0; 1; 0; 0]);;
assert(updateCounts(3,updateCounts(3,zeroCounts(6))) =  [0; 0; 0; 2; 0; 0]);;
assert(updateCounts(1,updateCounts(3,updateCounts(3,zeroCounts(6)))) = [0; 1; 0; 2; 0; 0]);;

(* updateMeansSum *)
assert(updateMeansSum([1.0;2.0;3.0],2,zeroMeansSet(4,3)) = [[0.; 0.; 0.]; [0.; 0.; 0.]; [1.; 2.; 3.]; [0.; 0.; 0.]]);;
assert(updateMeansSum([1.0;2.0;3.0],0,zeroMeansSet(4,3)) = [[1.; 2.; 3.]; [0.; 0.; 0.]; [0.; 0.; 0.]; [0.; 0.; 0.]]);;
assert(updateMeansSum([3.0;2.0;1.0],3,updateMeansSum([1.0;2.0;3.0],0,zeroMeansSet(4,3))) = [[1.; 2.; 3.]; [0.; 0.; 0.]; [0.; 0.; 0.]; [3.; 2.; 1.]]);;
assert(updateMeansSum([1.0;2.0;3.0],2,updateMeansSum([1.0;2.0;3.0],2,zeroMeansSet(4,3))) = [[0.; 0.; 0.]; [0.; 0.; 0.]; [2.; 4.; 6.]; [0.; 0.; 0.]]);;

(* formNewMeans *)
assert(formNewMeans([[100.5];[-29.1]], [3;5]) = [[33.5]; [-5.82]]);;

(* reclassify *)
#use "inputs.caml";;
let muzero = [[-57.244999; -43.969002]; [-68.746002; -55.521999]];;

let mu1 = reclassify(h,muzero,zeroMeansSet(2,2),zeroCounts(2));;
assert(mu1 = [[7.09669729142857; 6.97822274285714084]; [-59.7644003600000104; -62.4527998400000044]]);;

let mu2 = reclassify(h,mu1,zeroMeansSet(2,2),zeroCounts(2));;
assert(mu2 = [[48.5825602000000174; 49.1188998900000087]; [-51.10444003; -52.52021005]]);;

let mu3 = reclassify(h,mu2,zeroMeansSet(2,2),zeroCounts(2));;
assert(mu3 = [[48.5825602000000174; 49.1188998900000087]; [-51.10444003; -52.52021005]]);;

(* cmeans *)
let muzero = [[-57.244999; -43.969002]; [-68.746002; -55.521999]];;
assert(cmeans(2,h,muzero) = [[48.5825602000000174; 49.1188998900000087]; [-51.10444003; -52.52021005]]);;

#use "test4d.caml";;
let muzero4 = [[11.739382; 11.130896; 5.769114; 11.800967];[0.27744; 7.263812; 4.742097; 6.796983]];;
let expected = [
  [5.91223877311895052; 0.987439540450160469; 6.27431081118970546;1.23034376655948985];
  [-1.28225301480968668; -6.19357348581312905; -1.56818392290657327;-6.55956124332180668]
];;
(* #trace cmeans;; *)
let actual = cmeans(2, v, muzero4);;
assert(actual = expected);;
(* #untrace cmeans;; *)