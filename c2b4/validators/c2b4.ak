use aiken/builtin.{serialise_data}

// Kiểu dữ liệu tùy chỉnh

// 1. Khởi tạo kiểu dữ liệu tùy chỉnh đơn giản

// Từ khóa khai báo: type

type Animal{
    // Animal { dog: ByteArray, cat: String }
    cat: String,
    dog: ByteArray
}

test init(){
    let your_pets = Animal { dog: "Thomas", cat: @"Tom" }
    let my_pets = Animal { cat: @"Loly", dog: "Daisy" }
    let my_dog = my_pets.dog
    let your_cat = your_pets.cat
    my_dog == "Daisy" && your_cat == @"Tom"
}

type Blockchain{
    Cardano { crypto: ByteArray }
    BitCoin { crypto: ByteArray }
    Other
}


test tCoin(){
    let coin1: Blockchain = Cardano { crypto: "ADA" }
    let coin2: Blockchain = BitCoin { crypto: "BTC" }
    let other_coin: Blockchain = Other

    expect Cardano { crypto } = coin1
    let ada = crypto
    expect BitCoin { crypto } = coin2
    let btc = crypto

    ada == "ADA" && btc == "BTC" && other_coin == Other
}

// 2. Option

type Option<a>{
    Some(a)
    None
}

fn get_head(t: List<a>){
    when t is{
        [a, ..] -> Some(a)
        [] -> None
    }
}

test tOption(){
    let lst = [1,2,3,4,5]
    let head = get_head(lst)
    let sm = when head is{
        Some(a) -> a
        None -> 0
    }
    sm == 1
}

// 3. Destructuring (Giải cấu trúc)

fn get_Crypto_Name(coin_name: Blockchain) {
    when coin_name is{
        Cardano { crypto } -> crypto
        BitCoin { crypto } -> crypto
        Other -> "SOL, ETH, DOT, ..."
    }
}

test tCryptoName(){
    // let coin1: Blockchain = Cardano { crypto: "ADA" }
    // let coin2: Blockchain = BitCoin { crypto: "BTC" }
    let other_coin: Blockchain = Other

    let crypto_name = get_Crypto_Name(other_coin)
    crypto_name == "SOL, ETH, DOT, ..."
}

type Score{
    Points(Int)
}

test tScore(){
    let score = Points(50)
    let Points(p) = score
    p == 50
}

type Dog{
    Dog{ name: ByteArray, cuteness: Int, age: Int }
}

test tDog(){
    let dog = Dog { name: "Thomas", cuteness: 9001, age: 3 }

    let Dog { name: name, cuteness: _, age: _ } = dog

    let Dog { age, .. } = dog
    name == "Thomas" && age == 3
}

// 4. Generics (Khái niệm tổng quát)
type Box<a>{
    Box(a)
}

test tBox(){
    let a = Box(110)
    let b = Box("Aiken tutorial")

    let Box(x) = a
    let Box(y) = b

    x == 110 && y == "Aiken tutorial"
}

// 5. Cập nhật dữ liệu của một biến sử dụng kiểu tùy chỉnh

// type Person{
//     name: ByteArray,
//     shoe_size: Int,
//     age: Int,
//     is_happy: Bool
// }

// fn have_birthday(person: Person){
//     Person { ..person, age: person.age + 1, is_happy: True }
// }

// test tPerson(){
//     let happy = Person { name: "Aiken", shoe_size: 41, age: 2, is_happy: False }
//     let new_happy = have_birthday(happy)

//     let Person { age, .. } = happy
//     let age1 = age
//     let Person { age, .. } = new_happy
//     let age2 = age

//     age1 == age2 - 1
// }

// 6. Biệt danh của các kiểu dữ liệu

type VerifycationKey = ByteArray

type Person = (String, Int)

fn create_person(name: String, age: Int) -> Person{
    (name, age)
}

// 7. Data

type Datum{
    count: Int,
}

fn to_datum(datum: Data) -> Datum{
    expect d: Datum = datum
    d
} 

test tOption1(){
    let x = Some(10)
    // let y = when x is{
    //     Some(x) -> x
    //     None -> None
    // }
    expect Some(y) = x
    y == 10

}