```bool, int, string, bytearray, data và void```

```list và tupple```

# Bool
True hoặc False

== độ ưu tiên là 4
&& độ ưu tiên là 3
|| độ ưu tiên là 2
! độ ưu tiên là 1
? độ ưu tiên là 1

let a = True
let b = False

?a && ?b

# Int
1_000_000 == 1000000

```
 0b00001111 == 15
 0o17 == 15
 0xF == 15
```

+, - có ưu tiên là 6
*, /, % có độ ưu tiên là 7

## Phép so sánh
==, >, >=, <, <= đều có độ ưu tiên là 4

# ByteArray

## Mảng Byte

```
#[10, 255]
#[1, 256]
```

`#[0xff, 0x42]`

## Chuỗi byte

`"foo" == #[0x66, 0x6f, 0x6f] == #[102, 111, 111]`

## Chuỗi byte được mã hóa hex

`vd: #"666f6f" == #[0x66, 0x6f, 0x6f] == #[102, 111, 111] == "foo"`

"666f6f" == #[0x36, 0x36, 0x36, 0x66, 0x36, 0x66] == #[54, 54, 54, 102, 54, 102]

# Tuples
(Int, Bytearray) (5, "oke")
(3,4, [1,2,3])

```
let point = (3,4)
let x = point.1st
let y = point.2nd
```

# List
`[1,2,3,4,5]`
`["hello", "oke", "aiken"]`
`[1,"oke"]`

`[2,..[6,7]] == [2,6,7]`

```
let x = [7,8]
let y = [6,..x] == [6,..[7,8]] == [6,7,8]
```

# Void

# Data

# Xâu

@"Hello, 
my name is Son!"

