let rec minElement = function 
  [] -> failwith "error with empty list"
  | [last] -> last
  | h::t -> min h (minElement(t))

let rec find = function
  ([], x) -> -1
  | (h::t, x) -> if h = x then 0 else 1 + find(t, x)