// (c) 2023 lemoncmd.
module proconio

[params]
pub struct InputConfig {
	max_string_len usize = 1_048_576
}

struct InputError {
	Error
	detail string
	typ    string
}

fn (err InputError) msg() string {
	return '${err.detail} while reading type: ${err.typ}'
}

fn new_input_error(detail string, typ string) IError {
	return IError(InputError{
		detail: detail
		typ: typ
	})
}

fn stack_input_error(typ string, err_ IError) IError {
	err := err_ as InputError
	return IError(InputError{
		detail: err.detail
		typ: '${err.typ}\nin ${typ}'
	})
}

pub fn input[T]() T {
	panic('unimplemented')
}

pub fn try_input[T]() !T {
	panic('unimplemented')
}
