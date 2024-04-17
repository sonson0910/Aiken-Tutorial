fn add(x: Int, y: Int){
    x + y
}

// fn multiply(x: Int, y: Int) -> Int{
//     x * y
// }

// test init(){
//     add(2, 3) == 5 && multiply(2,3) == 6
// }

// fn twice(f: fn(t) -> t, x: t) -> t{
//   f(f(x)) // f(x) + 1 == (x + 1) + 1 == x + 2 == 2 + 2 == 4
// }

// fn add_one(x: Int) -> Int{
//   x + 1
// }

// fn add_two(x: Int) -> Int{
//   twice(add_one, x)
// }

// test tFunction(){
//     add_two(2) == 2 + 1 + 1
// }

// fn run(){
//   let add = fn(x, y) {x + y}

//   add(1,2)
// }

// test tAnony(){
//     run() == 3
// }


// // Ràng buộc kiểu dữ liệu đầu vào
// fn hello(s1: Int, s2: Int, s: Int){
//     s1 + s2 == s
// }

// test tHello(){
//     hello(s1: 1, s2: 2, s:3) == hello(s2: 2, s1: 1, s: 3) && hello(s2: 2, s1: 1, s: 3) == hello(s1: 1, s: 3, s2: 2)
// }

// fn tHelloWorld(helloworld h: ByteArray){
//     h == "Hello World!"
// }

// test tDS(){
//     tHelloWorld("Hello World!")
// }


// validator(asset: ByteArray){
//     fn contract(datum: Data, redeemer: Void, ctx: Data){
//         True
//     }

//     fn bid(datum: Data, ctx: Data){
//         True
//     }
// }


// test tPipe(){
//     let a = add(2, add(3, add(4, 5)))
//     let b = 
//      5
//       |> add(4)
//       |> add(3)
//       |> add(2)
//     a == b
// }

test run2(){
    let add_one = add(1, _)

    add_one(2) == 3
}

fn list_of_two(my_value m: a) -> List<a>{
    [m, m]
}

test double_number(){
    list_of_two(2) == [2,2]
}

test double_str(){
    list_of_two("a") == ["a","a"]
}

// 8. Hàm trả về kiểu dữ liệu xác định

fn add_three_number(x: Int, y: Int, z: Int) -> Int{
    x + y + z
}

test add_three(){
    let a = 
     4
      |> add(5)
      |> add(6)

    a == add_three_number(4,5,6)
}

