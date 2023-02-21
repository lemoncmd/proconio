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
