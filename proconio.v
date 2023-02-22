// (c) 2023 lemoncmd.
module proconio

[params]
pub struct InputConfig {
	max_string_len int = 1_048_576
	array_len      []int
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

fn read_array[T](_ []T, len []int) []T {
	mut arr := []T{len: len[0]}
	for i in 0 .. len[0] {
		$if T is $Array {
			arr[i] = read_array(T{}, len#[1..])
		} $else {
			arr[i] = input[T]()
		}
	}
	return arr
}

fn try_read_array[T](_ []T, len []int) ![]T {
	if len.len == 0 {
		return new_input_error('You must specify the array length.', 'Array')
	}
	mut arr := []T{len: len[0]}
	for i in 0 .. len[0] {
		$if T is $Array {
			arr[i] = try_read_array(T{}, len#[1..]) or { return stack_input_error('Array', err) }
		} $else {
			arr[i] = input[T]() or { return stack_input_error('Array', err) }
		}
	}
	return arr
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
	} $else $if T is $Array {
		return read_array(T{}, config.array_len)
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
	} $else $if T is $Array {
		return try_read_array(T{}, config.array_len)!
	} $else {
		panic('unimplemented')
	}
}
