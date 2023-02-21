// (c) 2023 lemoncmd.
module proconio

[params]
pub struct InputConfig {
	max_string_len int = 1_048_576
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

fn stack_input_error(typ string, err IError) IError {
	if err is InputError {
		return IError(InputError{
			detail: err.detail
			typ: '${err.typ}\nin ${typ}'
		})
	}
	return err
}

pub fn input[T](config InputConfig) T {
	$if T is u8 {
		return u8(read_u64())
	} $else $if T is u16 {
		return u16(read_u64())
	} $else $if T is u32 {
		return u32(read_u64())
	} $else $if T is u64 {
		return read_u64()
	} $else $if T is usize {
		return usize(read_u64())
	} $else $if T is int {
		return int(read_i64())
	} $else $if T is i8 {
		return i8(read_i64())
	} $else $if T is i16 {
		return i16(read_i64())
	} $else $if T is i32 {
		return i32(read_i64())
	} $else $if T is i64 {
		return read_i64()
	} $else $if T is isize {
		return isize(read_i64())
	} $else $if T is f32 {
		return read_f32()
	} $else $if T is f64 {
		return read_f64()
	} $else $if T is rune {
		return read_rune()
	} $else $if T is string {
		return read_string(config.max_string_len)
	} $else {
		panic('unimplemented')
	}
}

pub fn try_input[T](config InputConfig) !T {
	$if T is u8 {
		return u8(try_read_u64()!)
	} $else $if T is u16 {
		return u16(try_read_u64()!)
	} $else $if T is u32 {
		return u32(try_read_u64()!)
	} $else $if T is u64 {
		return try_read_u64()!
	} $else $if T is int {
		return int(try_read_i64()!)
	} $else $if T is i8 {
		return i8(try_read_i64()!)
	} $else $if T is i16 {
		return i16(try_read_i64()!)
	} $else $if T is i32 {
		return i32(try_read_i64()!)
	} $else $if T is i64 {
		return try_read_i64()!
	} $else $if T is f32 {
		return try_read_f32()!
	} $else $if T is f64 {
		return try_read_f64()!
	} $else $if T is rune {
		return try_read_rune()!
	} $else $if T is string {
		return read_string(config.max_string_len)
	} $else {
		panic('unimplemented')
	}
}
