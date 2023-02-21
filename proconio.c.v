// (c) 2023 lemoncmd.
module proconio

#include <stdio.h>

fn C.scanf(&char, ...voidptr) int

fn read_i64() i64 {
	number := i64(0)
	unsafe { C.scanf(c'%lld', &number) }
	return number
}

fn read_u64() u64 {
	number := u64(0)
	unsafe { C.scanf(c'%llu', &number) }
	return number
}

fn read_string() string {
	panic('unimplemented')
}

fn try_read_i64() !i64 {
	number := i64(0)
	err := unsafe { C.scanf(c'%lld', &number) }
	if err > 0 {
		return number
	}
	if err == 0 {
		return new_input_error('Unable to read number', 'signed integer')
	}
	if err < 0 {
		return new_input_error('Reached EOF', 'signed integer')
	}
}

fn try_read_u64() !u64 {
	number := u64(0)
	err := unsafe { C.scanf(c'llu', &number) }
	if err > 0 {
		return number
	}
	if err == 0 {
		return new_input_error('Unable to read number', 'unsigned integer')
	}
	if err < 0 {
		return new_input_error('Reached EOF', 'unsigned integer')
	}
}

fn try_read_string() !string {
	panic('unimplemented')
}
