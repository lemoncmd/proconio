// (c) 2023 lemoncmd.
module proconio

[params]
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

fn read_array[T](_ []T, len []int) []T {
	mut arr := []T{len: len[0]}
	for i in 0 .. len[0] {
		$if T is $array {
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
		$if T is $array {
			arr[i] = try_read_array(T{}, len#[1..]) or { return stack_input_error('Array', err) }
		} $else {
			arr[i] = try_input[T]() or { return stack_input_error('Array', err) }
		}
	}
	return arr
}

[inline]
fn input_field[T](_ T, config InputConfig) T {
	return input[T](config)
}

[inline]
fn try_input_field[T](_ T, config InputConfig) !T {
	return try_input[T](config)
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
	// once V bug is fixed, delete below
	} $else $if T is []u8 {
		mut arr := []u8{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[u8]()
		}
		return arr
	} $else $if T is []u16 {
		mut arr := []u16{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[u16]()
		}
		return arr
	} $else $if T is []u32 {
		mut arr := []u32{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[u32]()
		}
		return arr
	} $else $if T is []u64 {
		mut arr := []u64{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[u64]()
		}
		return arr
	} $else $if T is []usize {
		mut arr := []usize{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[usize]()
		}
		return arr
	} $else $if T is []int {
		mut arr := []int{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[int]()
		}
		return arr
	} $else $if T is []i8 {
		mut arr := []i8{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[i8]()
		}
		return arr
	} $else $if T is []i16 {
		mut arr := []i16{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[i16]()
		}
		return arr
	} $else $if T is []i32 {
		mut arr := []i32{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[i32]()
		}
		return arr
	} $else $if T is []i64 {
		mut arr := []i64{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[i64]()
		}
		return arr
	} $else $if T is []isize {
		mut arr := []isize{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[isize]()
		}
		return arr
	} $else $if T is []f32 {
		mut arr := []f32{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[f32]()
		}
		return arr
	} $else $if T is []f64 {
		mut arr := []f64{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[f64]()
		}
		return arr
	} $else $if T is []rune {
		mut arr := []rune{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[rune]()
		}
		return arr
	} $else $if T is []string {
		mut arr := []string{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[string]()
		}
		return arr
	} $else $if T is [][]u8 {
		mut arr := [][]u8{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[]u8](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][]u16 {
		mut arr := [][]u16{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[]u16](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][]u32 {
		mut arr := [][]u32{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[]u32](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][]u64 {
		mut arr := [][]u64{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[]u64](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][]usize {
		mut arr := [][]usize{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[]usize](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][]int {
		mut arr := [][]int{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[]int](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][]i8 {
		mut arr := [][]i8{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[]i8](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][]i16 {
		mut arr := [][]i16{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[]i16](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][]i32 {
		mut arr := [][]i32{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[]i32](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][]i64 {
		mut arr := [][]i64{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[]i64](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][]isize {
		mut arr := [][]isize{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[]isize](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][]f32 {
		mut arr := [][]f32{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[]f32](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][]f64 {
		mut arr := [][]f64{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[]f64](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][]rune {
		mut arr := [][]rune{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[]rune](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][]string {
		mut arr := [][]string{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[]string](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][][]u8 {
		mut arr := [][]u8{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[][]u8](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][][]u16 {
		mut arr := [][]u16{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[][]u16](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][][]u32 {
		mut arr := [][]u32{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[][]u32](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][][]u64 {
		mut arr := [][]u64{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[][]u64](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][][]usize {
		mut arr := [][]usize{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[][]usize](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][][]int {
		mut arr := [][]int{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[][]int](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][][]i8 {
		mut arr := [][]i8{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[][]i8](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][][]i16 {
		mut arr := [][]i16{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[][]i16](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][][]i32 {
		mut arr := [][]i32{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[][]i32](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][][]i64 {
		mut arr := [][]i64{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[][]i64](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][][]isize {
		mut arr := [][]isize{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[][]isize](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][][]f32 {
		mut arr := [][]f32{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[][]f32](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][][]f64 {
		mut arr := [][]f64{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[][]f64](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][][]rune {
		mut arr := [][]rune{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[][]rune](len: config.len#[1..])
		}
		return arr
	} $else $if T is [][][]string {
		mut arr := [][]string{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = input[[][]string](len: config.len#[1..])
		}
		return arr
	} $else $if T is $array {
		return read_array(T{}, config.len)
	} $else $if T is $struct {
		mut strc := T{}
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
					strc.$(field.name) = input_field(strc.$(field.name),
						max_string_len: config.max_string_len
						len: len
					)
				} $else $if field.is_struct {
					strc.$(field.name) = input_field(strc.$(field.name), config)
				} $else $if field.typ is string {
					strc.$(field.name) = input_field(strc.$(field.name), config)
				} $else {
					strc.$(field.name) = input_field(strc.$(field.name), config)
					variable[field.name] = int(strc.$(field.name))
				}
			}
		} else {
			$for field in T.fields {
				strc.$(field.name) = input_field(strc.$(field.name), config)
			}
		}
		return strc
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
	} $else $if T is []u8 {
		mut arr := []u8{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[u8]() or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is []u16 {
		mut arr := []u16{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[u16]() or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is []u32 {
		mut arr := []u32{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[u32]() or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is []u64 {
		mut arr := []u64{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[u64]() or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is []usize {
		mut arr := []usize{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[usize]() or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is []int {
		mut arr := []int{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[int]() or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is []i8 {
		mut arr := []i8{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[i8]() or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is []i16 {
		mut arr := []i16{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[i16]() or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is []i32 {
		mut arr := []i32{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[i32]() or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is []i64 {
		mut arr := []i64{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[i64]() or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is []isize {
		mut arr := []isize{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[isize]() or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is []f32 {
		mut arr := []f32{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[f32]() or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is []f64 {
		mut arr := []f64{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[f64]() or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is []rune {
		mut arr := []rune{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[rune]() or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is []string {
		mut arr := []string{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[string]() or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][]u8 {
		mut arr := [][]u8{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[]u8](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][]u16 {
		mut arr := [][]u16{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[]u16](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][]u32 {
		mut arr := [][]u32{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[]u32](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][]u64 {
		mut arr := [][]u64{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[]u64](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][]usize {
		mut arr := [][]usize{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[]usize](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][]int {
		mut arr := [][]int{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[]int](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][]i8 {
		mut arr := [][]i8{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[]i8](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][]i16 {
		mut arr := [][]i16{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[]i16](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][]i32 {
		mut arr := [][]i32{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[]i32](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][]i64 {
		mut arr := [][]i64{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[]i64](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][]isize {
		mut arr := [][]isize{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[]isize](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][]f32 {
		mut arr := [][]f32{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[]f32](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][]f64 {
		mut arr := [][]f64{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[]f64](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][]rune {
		mut arr := [][]rune{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[]rune](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][]string {
		mut arr := [][]string{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[]string](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][][]u8 {
		mut arr := [][]u8{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[][]u8](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][][]u16 {
		mut arr := [][]u16{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[][]u16](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][][]u32 {
		mut arr := [][]u32{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[][]u32](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][][]u64 {
		mut arr := [][]u64{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[][]u64](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][][]usize {
		mut arr := [][]usize{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[][]usize](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][][]int {
		mut arr := [][]int{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[][]int](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][][]i8 {
		mut arr := [][]i8{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[][]i8](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][][]i16 {
		mut arr := [][]i16{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[][]i16](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][][]i32 {
		mut arr := [][]i32{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[][]i32](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][][]i64 {
		mut arr := [][]i64{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[][]i64](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][][]isize {
		mut arr := [][]isize{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[][]isize](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][][]f32 {
		mut arr := [][]f32{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[][]f32](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][][]f64 {
		mut arr := [][]f64{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[][]f64](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][][]rune {
		mut arr := [][]rune{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[][]rune](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is [][][]string {
		mut arr := [][]string{len: config.len[0]}
		for i in 0 .. config.len[0] {
			arr[i] = try_input[[][]string](len: config.len#[1..]) or { stack_input_error("Array", err) }
		}
		return arr
	} $else $if T is $array {
		return try_read_array(T{}, config.len)!
	} $else $if T is $struct {
		mut strc := T{}
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
					strc.$(field.name) = try_input_field(strc.$(field.name),
						max_string_len: config.max_string_len
						len: len
					) or { return stack_input_error(typeof[T]().name, err) }
				} $else $if field.is_struct {
					strc.$(field.name) = try_input_field(strc.$(field.name), config) or { return stack_input_error(typeof[T]().name, err) }
				} $else $if field.typ is string{
					strc.$(field.name) = try_input_field(strc.$(field.name), config) or { return stack_input_error(typeof[T]().name, err) }
				} $else {
					strc.$(field.name) = try_input_field(strc.$(field.name), config) or { return stack_input_error(typeof[T]().name, err) }
					variable[field.name] = int(strc.$(field.name))
				}
			}
		} else {
			$for field in T.fields {
				strc.$(field.name) = try_input_field(strc.$(field.name), config) or { return stack_input_error(typeof[T]().name, err) }
			}
		}
		return strc
	} $else {
		panic('unimplemented')
	}
}
