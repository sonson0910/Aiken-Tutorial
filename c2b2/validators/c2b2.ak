// test init(){
//     let x = 1
//     let s = "Aiken"
//     // x == 1 && s == "Aiken"

//     // let y = x
//     let x = 2
//     x == 2
// }

// type Option<a>{
//     Some(a)
//     None
// }

// test tExpect(){
//     let a = Some(4)
//     expect Some(b) = a
//     b == 4
// }

const x = 2

test tConst(){
    let x = 3
    x == 3
}

test tConst2(){
    x == 2
}

const s:ByteArray = "Aiken"

test tRB(){
    let a: Int = 2
    let u: Bool = s == "Aiken" && a == 2
    u
}