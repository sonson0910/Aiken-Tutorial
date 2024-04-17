# Biến & hằng

1. Biến/let-bindings

```    let x = 1
    let s = "Aiken"
    // x == 1 && s == "Aiken"

    // let y = x
    let x = 2
    x == 2
```

2. Expect

vd:

type Option<a> {
  Some(a)
  None
}

let a = Some(4)
expect Some(b) = a

b == 4

3. Constant

vd: 
```
const YEAR = 2024
```

Lưu ý: Aiken chỉ có thể khai báo cho một số kiểu dữ liệu: Int, ByteArray, String

4. Ràng buộc kiểu
vd:

```
let a: Int = 5
const name: ByteArray = "Aiken"
let u: Bool = 2 > 3
```