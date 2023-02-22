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
	/*
	init_stdin('1 2 3')!
	a := input[[]int](array_len: [3])
	assert a == [int(1),2,3]
	*/
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

	/*
	init_stdin('3\n1 2 3')!
	b := input[Bar]()
	assert b.a == [int(1), 2, 3]
	*/
	init_stdin('2 3\n1 2 3\n4 5 6')!
	c := input[Baz]()
	assert c.a == [[int(1), 2, 3], [4, 5, 6]]
}
