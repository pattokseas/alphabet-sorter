let letter_word = function
    | 'a' | 'A' -> "a"
    | 'b' | 'B' -> "bee"
    | 'c' | 'C' -> "cee"
    | 'd' | 'D' -> "dee"
    | 'e' | 'E' -> "ee"
    | 'f' | 'F' -> "ef"
    | 'g' | 'G' -> "gee"
    | 'h' | 'H' -> "aitch"
    | 'i' | 'I' -> "i"
    | 'j' | 'J' -> "jay"
    | 'k' | 'K' -> "kay"
    | 'l' | 'L' -> "el"
    | 'm' | 'M' -> "em"
    | 'n' | 'N' -> "en"
    | 'o' | 'O' -> "o"
    | 'p' | 'P' -> "pee"
    | 'q' | 'Q' -> "cue"
    | 'r' | 'R' -> "ar"
    | 's' | 'S' -> "ess"
    | 't' | 'T' -> "tee"
    | 'u' | 'U' -> "u"
    | 'v' | 'V' -> "vee"
    | 'w' | 'W' -> "double-u"
    | 'x' | 'X' -> "ex"
    | 'y' | 'Y' -> "wye"
    | 'z' | 'Z' -> "zee"
    | _ -> ""

let get_index letter order =
    let rec aux letter i = function
        | h::t when h = letter -> i
        | h::t -> aux letter (i + 1) t
        | [] -> -1
    in aux (Char.lowercase_ascii letter) 0 order

let initial_order = [
    'a'; 'b'; 'c'; 'd'; 'e'; 'f'; 'g'; 'h'; 'i'; 'j'; 'k'; 'l'; 'm';
    'n'; 'o'; 'p'; 'q'; 'r'; 's'; 't'; 'u'; 'v'; 'w'; 'x'; 'y'; 'z'
]

let cmp x y order = 
    let diff = (get_index x order) - (get_index y order) in
    if diff < 0 then -1
    else if diff = 0 then 0
    else 1

let cmp_words x y order = 
    let xlen, ylen = String.length x, String.length y in
    let rec aux i =
        if i >= xlen then (if i >= ylen then 0 else -1)
        else if i >= ylen then 1
        else let c = cmp x.[i] y.[i] order in
            if c <> 0 then c else aux (i + 1)
    in aux 0

let cmp_letter x y order =
    cmp_words (letter_word x) (letter_word y) order

let rec merge_sort lst cmp =
    match lst with
    | [] -> []
    | [h] -> [h]
    | _ -> 
    let list_len (lst : 'a list) : int =
        let rec aux len = function
            | [] -> len
            | _::t -> aux (len + 1) t
        in aux 0 lst
    in let split_list (lst : 'a list) : 'a list * 'a list =
        let half = (list_len lst) / 2
        in let rec aux xs ys i = function
            | [] -> xs, ys
            | h::t when i < half -> aux (h::xs) ys (i + 1) t
            | h::t -> aux xs (h::ys) (i + 1) t
        in aux [] [] 0 lst
    in let rec merge (acc : 'a list) (xs : 'a list) (ys : 'a list) (cmp : 'a -> 'a -> int) : 'a list =
        match xs, ys with
        | [], [] -> List.rev acc
        | h::t, [] -> merge (h::acc) t [] cmp
        | [], h::t -> merge (h::acc) [] t cmp
        | hx::tx, hy::ty when cmp hx hy < 0 -> merge (hx::acc) tx ys cmp
        | _, h::t -> merge (h::acc) xs t cmp
    in let lower, upper = split_list lst in
    let lower_sorted = merge_sort lower cmp in
    let upper_sorted = merge_sort upper cmp in
    merge [] lower_sorted upper_sorted cmp

let new_order initial_order = 
    merge_sort initial_order (fun x y -> cmp_letter x y initial_order)

let rec find_consistent_order initial_order =
    let next_order = new_order initial_order in
    if next_order = initial_order then initial_order
    else find_consistent_order next_order

let print_order order =
    let rec aux = function
        | [] -> ()
        | h::t -> (Printf.printf "%c " (Char.uppercase_ascii h); aux t)
    in aux order; Printf.printf "\n"

let main () = print_order (find_consistent_order initial_order)
