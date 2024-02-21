# Alphabet Sorter
The traditional alphabet is not in alphabetical order based on the phonetic spellings of the letters. 
This OCaml script finds an alphabet which is in alphabetical order, where the alphabetical order is defined by that alphabet itself. 
In other words, the script finds an internally consistent alphabetical alphabet. 
It does this iteratively by sorting the alphabet according to the current letter order to get a new alphabet.
It then sorts that new alphabet by the order it defines, and repeats the process until it gets an alphabet that doesn't change when it is sorted.
This process depends on the initial alphabet then, so there isn't just one possible internally consistent alphabetical alphabet. Starting with a different initial order could get a different result.
The process also depends on the phonetic spellings of the letters. This script uses the spellings given on Wikipedia, but different spellings could give different results.

Using the traditional alphabet as the initial alphabet and the phonetic spellings from Wikipedia, the resulting alphabet is A R H B C Q D W Y E F L M N S X G I J K O P T U V Z.

To run the script in utop, run `ocaml -init alphasort.ml`.
In utop, `main ();;` will print the alphabet resulting from the traditional alphabet.
To use a different order, you can use `print_order (find_consistent_order ORDER)` where `ORDER` is a list defining the alphabet, e.g. `['a'; 'b'; 'c'; 'd'; 'e'; 'f'; 'g'; 'h'; 'i'; 'j'; 'k'; 'l'; 'm'; 'n'; 'o'; 'p'; 'q'; 'r'; 's'; 't'; 'u'; 'v'; 'w'; 'x'; 'y'; 'z']`

You can also run the binary main on Linux with `./main`. Main simply prints the alphabet resulting from the traditional alphabet.
You can compile main with `ocamlopt alphasort.ml main.ml -o main`
