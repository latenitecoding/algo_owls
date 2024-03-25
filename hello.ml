(* ======================================================== *)
(* Helpers *)
(* ======================================================== *)

let next () = 
    let input = Scanf.scanf "%s" (fun x -> x) in
    Scanf.scanf "%c" (fun _ -> ());
    input;;

let next_array () = read_line ()
    |> String.split_on_char ' '
    |> List.filter (fun s -> s <> "")
    |> List.map int_of_string;;

let next_float () = read_float ();;

let next_int () = read_int ();;

let next_line () = read_line ();;

let next_tuple () =
    let left = int_of_string (next ()) in
    let right = int_of_string (next ()) in
    (left, right);;

(* ======================================================== *)
(* Solution *)
(* ======================================================== *)

let main () = print_endline "Hello, World!";;

let () = main ();;
