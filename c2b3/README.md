# Function

1. Khai báo hàm:
 Từ khóa fn

```
fn add(x: Int, y: Int){
  x + y
}

fn multiply(x: Int, y: Int) -> Int{
  x * y
}
```

vd:
```
fn add(x: Int, y: Int){
  x + y
}

fn twice(f: fn(t) -> t, x: t) -> t{
  f(f(t))
}

fn add_one(x: Int) -> Int{
  x + 1
}

fn add_two(x: Int) -> Int{
  twice(add_one, x)
}

```

2. Hàm ẩn danh

```
vd:
fn run(){
  let add = fn(x, y) {x + y}

  add(1,2) == 3
}
```

3. Đối số có ràng buộc kiểu dữ liệu

```fn hello(s1: Int, s2: Int, s: Int){
    s1 + s2 == s
}

test tHello(){
    hello(s1: 1, s2: 2, s:3) == hello(s2: 2, s1: 1, s: 3) && hello(s2: 2, s1: 1, s: 3) == hello(s1: 1, s: 3, s2: 2)
}

fn tHelloWorld(helloworld h: ByteArray){
    h == "Hello World!"
}

test tDS(){
    tHelloWorld("Hello World!")
}
```

4. Validator

```validator(asset: ByteArray){
    fn contract(datum: Data, redeemer: Void, ctx: Data){
        True
    }

    fn bid(datum: Data, ctx: Data){
        True
    }
}
```

5. Toán tử pipe
- Được kí hiệu: |>

```test tPipe(){
    let a = add(2, add(3, add(4, 5)))
    let b = 
     5
      |> add(4)
      |> add(3)
      |> add(2)
    a == b
}
```

6. Function capturing

```
test run2(){
    let add_one = add(1, _)

    add_one(2) == 3
}
```

7. Hàm chung

```fn list_of_two(my_value m: a) -> List<a>{
    [m, m]
}

test double_number(){
    list_of_two(2) == [2,2]
}

test double_str(){
    list_of_two("a") == ["a","a"]
}
```

8. Hàm trả về kiểu dữ liệu xác định
