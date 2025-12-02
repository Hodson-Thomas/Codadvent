let names = ["Rudolph"; "Dasher"; "Daneer"; "Praneer"; "Tixen"; "Cupid"; "Comet"; "Donner"; "Blitzen"]

type reindeer = {
  name: string;
  is_present: bool;
}

let create_reindeer name =
  { name = name; is_present = Random.bool () }

let countPresentReindeers reindeers = 
  let rec count_aux remaining total =
    match remaining with
    | h :: t -> 
        if h.is_present 
        then  count_aux t (total + 1)
        else count_aux t total
    | _ -> total 
  in count_aux reindeers 0 

let _ = 
  print_string "There are ";
  List.map create_reindeer names |> countPresentReindeers |> print_int ;
  print_string " present reindeer(s).";
  print_newline ()