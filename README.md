# proconio
proconio for the V programming language

useful io library for programming contests

# usage
```v
import proconio

struct Vec2 {
  x u64
  y u64
}

struct Input {
  i usize // structs are read from top
  j usize
  c rune // you can input a character by this
  s string // you can also read string
  a []u64 [i] // you can specify how many times you want to read by variable
  x []Vec2 [j] // you can also specify an array of a struct
  y [][]u64 [i;j] // you can input multi-dimentional array by splitting with ;
}

i := proconio.input[u64]() // you can specify what type you want to read by a generic parameter
input := proconio.input[Input]() // you can also use a struct
vec := proconio.try_input[Vec2]()? // try_input is `input` which returns Result of the specified type
// try_input can check whether input is EOF or not
```
