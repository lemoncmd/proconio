module proconio

import os

fn init_stdin(s string) ! {
	mut f := os.create('./tmp')!
	f.write_string(s)!
	f.close()
	mut stdin := os.stdin()
	stdin.reopen('./tmp', 'r')!
}

fn testsuite_end() ! {
	os.rm('./tmp')!
}

fn test_i8() ! {
	init_stdin('23')!
	a := input[i8]()
	assert a == 23
}

fn test_i64() ! {
	init_stdin('-12356')!
	a := input[i64]()
	assert a == -12356
}

fn test_u64() ! {
	init_stdin('18446744073709551615')!
	a := input[u64]()
	assert a == 18446744073709551615
}

fn test_f32() ! {
	init_stdin('2.3')!
	a := input[f32]()
	assert a == 2.3
}

fn test_rune() ! {
	init_stdin('a')!
	a := input[rune]()
	assert a == `a`

	init_stdin('あ')!
	b := input[rune]()
	assert b == `あ`
}

fn test_string() ! {
	init_stdin('cogito ergo\nsum')!
	a := input[string]()
	assert a == 'cogito'
	b := input[string]()
	assert b == 'ergo'
	c := input[string]()
	assert c == 'sum'
}

fn test_array() ! {
	init_stdin('1 2 3')!
	a := input[[]int](array_len: [3])
	assert a == [int(1), 2, 3]

	init_stdin('1 2 3\n4 5 6')!
	b := input[[][]int](array_len: [2, 3])
	assert b == [[int(1), 2, 3], [4, 5, 6]]
}

struct Foo {
	a u64
	b u64
	c u64
}

struct Bar {
	i int
	a []int [i]
}

struct Baz {
	i int
	j int
	a [][]int [i; j]
}

fn test_struct() ! {
	init_stdin('1 2 3')!
	a := input[Foo]()
	assert a.a == 1 && a.b == 2 && a.c == 3

	init_stdin('3\n1 2 3')!
	b := input[Bar]()
	assert b.a == [int(1), 2, 3]

	init_stdin('2 3\n1 2 3\n4 5 6')!
	c := input[Baz]()
	assert c.a == [[int(1), 2, 3], [4, 5, 6]]
}

struct Vec2 {
	x u64
	y u64
}

struct Input {
	i usize // structs are read from top
	j usize
	c rune   // you can input a character by this
	s string // you can also read string
	a []u64   [i] // you can specify how many times you want to read by variable
	x []Vec2  [j] // you can also specify an array of a struct
	y [][]u64 [i; j] // you can input multi-dimentional array by splitting with ;
}

fn test_readme() ! {
	init_stdin('5\n2 3a foo\n4 5\n6 7\n8 9\n10 11\n1 2 3\n4 5 6\n5 4 3 2 1\n-3 -4')!
	i := input[u64]() // you can specify what type you want to read by a generic parameter
	inp := input[Input]() // you can also use a struct
	arr := input[[]int](array_len: [int(i)]) // you can input an array
	// currently unavailable because of cgen bug. use try_input[u64]()! instead.
	//	vec := try_input[Vec2]()! // try_input is `input` which returns Result of the specified type

	assert i == 5
	println(inp)
	assert arr == [int(5), 4, 3, 2, 1]
	//	assert vec.x == -3
}
