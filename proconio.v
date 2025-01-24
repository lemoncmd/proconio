// (c) 2023-2025 lemoncmd.
module proconio

@[params]
pub struct InputConfig {
	max_string_len int = 1_048_576
	len      []int
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

fn read_array[T](mut arr []T, len []int) {
	for _ in 0 .. len[0] {
		arr << input[T](len: len#[1..])
	}
}

fn try_read_array[T](mut arr []T, len []int) ! {
	if len.len == 0 {
		return new_input_error('You must specify the array length.', 'Array')
	}
	for _ in 0 .. len[0] {
		arr << try_input[T](len: len#[1..]) or { return stack_input_error('Array', err) }
	}
	return arr
}

@[inline]
fn input_field[T](_ T, config InputConfig) T {
	return input[T](config)
}

@[inline]
fn try_input_field[T](_ T, config InputConfig) !T {
	return try_input[T](config)
}

pub fn input[T](config InputConfig) T {
	mut val := T{}
	input_impl(mut val, config)
	return val
}

fn input_impl[T](mut val T, config InputConfig) {
	$if T is u8 {
		val = u8(read_u64())
	} $else $if T is u16 {
		val = u16(read_u64())
	} $else $if T is u32 {
		val = u32(read_u64())
	} $else $if T is u64 {
		val = read_u64()
	} $else $if T is usize {
		val = usize(read_u64())
	} $else $if T is int {
		val = int(read_i64())
	} $else $if T is i8 {
		val = i8(read_i64())
	} $else $if T is i16 {
		val = i16(read_i64())
	} $else $if T is i32 {
		val = i32(read_i64())
	} $else $if T is i64 {
		val = read_i64()
	} $else $if T is isize {
		val = isize(read_i64())
	} $else $if T is f32 {
		val = read_f32()
	} $else $if T is f64 {
		val = read_f64()
	} $else $if T is rune {
		val = read_rune()
	} $else $if T is string {
		val = read_string(config.max_string_len)
	} $else $if T is $array {
		read_array(mut val, config.len)
	} $else $if T is $struct {
		mut has_array := false
		$for field in T.fields {
			$if field.is_array {
				has_array = true
			}
		}
		if has_array {
			mut variable := map[string]int{}
			$for field in T.fields {
				$if field.is_array {
					mut len := []int{}
					for attr in field.attrs {
						len << variable[attr]
					}
					val.$(field.name) = input_field(val.$(field.name),
						max_string_len: config.max_string_len
						len: len
					)
				} $else $if field.is_struct {
					val.$(field.name) = input_field(val.$(field.name), config)
				} $else $if field.typ is string {
					val.$(field.name) = input_field(val.$(field.name), config)
				} $else {
					val.$(field.name) = input_field(val.$(field.name), config)
					variable[field.name] = int(val.$(field.name))
				}
			}
		} else {
			$for field in T.fields {
				val.$(field.name) = input_field(val.$(field.name), config)
			}
		}
	} $else {
		panic('unimplemented')
	}
}

pub fn try_input[T](config InputConfig) !T {
	mut val := T{}
	try_input_impl(mut val, config)!
	return val
}

fn try_input_impl[T](mut val T, config InputConfig) ! {
	$if T is u8 {
		val = u8(try_read_u64()!)
	} $else $if T is u16 {
		val = u16(try_read_u64()!)
	} $else $if T is u32 {
		val = u32(try_read_u64()!)
	} $else $if T is u64 {
		val = try_read_u64()!
	} $else $if T is int {
		val = int(try_read_i64()!)
	} $else $if T is i8 {
		val = i8(try_read_i64()!)
	} $else $if T is i16 {
		val = i16(try_read_i64()!)
	} $else $if T is i32 {
		val = i32(try_read_i64()!)
	} $else $if T is i64 {
		val = try_read_i64()!
	} $else $if T is f32 {
		val = try_read_f32()!
	} $else $if T is f64 {
		val = try_read_f64()!
	} $else $if T is rune {
		val = try_read_rune()!
	} $else $if T is string {
		val = read_string(config.max_string_len)
	} $else $if T is $array {
		try_read_array(mut val, config.len)!
	} $else $if T is $struct {
		mut has_array := false
		$for field in T.fields {
			$if field.is_array {
				has_array = true
			}
		}
		if has_array {
			mut variable := map[string]int{}
			$for field in T.fields {
				$if field.is_array {
					mut len := []int{}
					for attr in field.attrs {
						len << variable[attr]
					}
					val.$(field.name) = try_input_field(val.$(field.name),
						max_string_len: config.max_string_len
						len: len
					) or { return stack_input_error(typeof[T]().name, err) }
				} $else $if field.is_struct {
					val.$(field.name) = try_input_field(val.$(field.name), config) or { return stack_input_error(typeof[T]().name, err) }
				} $else $if field.typ is string{
					val.$(field.name) = try_input_field(val.$(field.name), config) or { return stack_input_error(typeof[T]().name, err) }
				} $else {
					val.$(field.name) = try_input_field(val.$(field.name), config) or { return stack_input_error(typeof[T]().name, err) }
					variable[field.name] = int(val.$(field.name))
				}
			}
		} else {
			$for field in T.fields {
				val.$(field.name) = try_input_field(val.$(field.name), config) or { return stack_input_error(typeof[T]().name, err) }
			}
		}
	} $else {
		panic('unimplemented')
	}
}
