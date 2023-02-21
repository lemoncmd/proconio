// (c) 2023 lemoncmd.
module proconio

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

fn read_f32() f32 {
	number := f32(0)
	unsafe { C.scanf(c'%f', &number) }
	return number
}

fn read_f64() f64 {
	number := f64(0)
	unsafe { C.scanf(c'%lf', &number) }
	return number
}

fn read_rune() rune {
	number := u8(0)
	unsafe { C.scanf(c'%c', &number) }
	if number < 128 {
		return rune(number)
	}
	mut buf := [number]
	for _ in 0 .. utf8_char_len(number) - 1 {
		rest := u8(0)
		unsafe { C.scanf(c'%c', &rest) }
		buf << rest
	}
	return buf.utf8_to_utf32() or { rune(number) }
}

fn read_string(buf_size int) string {
	buf := []u8{len: buf_size}
	unsafe { C.scanf(c'%s', &buf[0]) }
	return unsafe { tos_clone(&buf[0]) }
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
	return new_input_error('Reached EOF', 'signed integer')
}

fn try_read_u64() !u64 {
	number := u64(0)
	err := unsafe { C.scanf(c'%llu', &number) }
	if err > 0 {
		return number
	}
	if err == 0 {
		return new_input_error('Unable to read number', 'unsigned integer')
	}
	return new_input_error('Reached EOF', 'unsigned integer')
}

fn try_read_f32() !f32 {
	number := f32(0)
	err := unsafe { C.scanf(c'%f', &number) }
	if err > 0 {
		return number
	}
	if err == 0 {
		return new_input_error('Unable to read number', 'unsigned integer')
	}
	return new_input_error('Reached EOF', 'unsigned integer')
}

fn try_read_f64() !f64 {
	number := f64(0)
	err := unsafe { C.scanf(c'%lf', &number) }
	if err > 0 {
		return number
	}
	if err == 0 {
		return new_input_error('Unable to read number', 'unsigned integer')
	}
	return new_input_error('Reached EOF', 'unsigned integer')
}

fn try_read_rune() !rune {
	number := u8(0)
	mut err := unsafe { C.scanf(c'%c', &number) }
	if err > 0 && number < 128 {
		return rune(number)
	}
	if err == 0 {
		return new_input_error('Unable to read character', 'rune')
	}
	if err < 0 {
		return new_input_error('Reached EOF', 'rune')
	}
	mut buf := [number]
	for _ in 0 .. utf8_char_len(number) - 1 {
		rest := u8(0)
		err = unsafe { C.scanf(c'%c', &rest) }
		if rest < 128 {
			return new_input_error('Could not decode character as UTF-8', 'rune')
		}
		if err == 0 {
			return new_input_error('Unable to read character', 'rune')
		}
		if err < 0 {
			return new_input_error('Reached EOF', 'rune')
		}
		buf << rest
	}
	return buf.utf8_to_utf32() or {
		return new_input_error('Could not decode character as UTF-8', 'rune')
	}
}
