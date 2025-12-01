open System
open System.IO

type Day1(file_path: string, password: string) =
    let file_path = file_path
    let letters = "abcdefghijklmnopqrstuvwxyz"
    let key = - password.Length + letters.Length

    member this.Convert =
        use reader = new StreamReader(file_path)
        this.convert_file reader ""
     
    member this.convert_file (reader: StreamReader) result =
        let line = reader.ReadLine()
        if line = null then
            result
        else
            this.convert_file reader (result + (this.convert_text (List.ofSeq line) "") + "\n")
        
    member this.convert_char c =
        let c = Char.ToLower(c)
        if Char.IsLetter c then
            let x = (letters.IndexOf c + key) % letters.Length
            letters[x]
        else
            c

    member this.convert_text remaining (result: string) =
        match remaining with
        | h :: t -> this.convert_text t (result + string (this.convert_char h)) 
        | _ -> result 
        

[<EntryPoint>]
let main argv =
    let d = Day1(@"day1.txt", "RENNE")
    printf "%s" d.Convert
    0