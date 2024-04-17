// Control flow

// 1. Khối
// {} ()

test init(){
    let x = { 4 + 10 } * 2 /  7 - 4
    x == 0
}

// 2. When .. is
test tWhenIs(){
    let some_number = 2
    let number_str = when some_number is{
        0 -> "Zero"
        1 -> "One"
        2 -> "Two"
        _ -> "Some other number"
    }
    number_str == "Two"
}

type Answer{
    Yes
    No
}

test tWhenIs2(){
    let answer = Yes
    let description = when answer is{
        Yes -> "It's true!"
        No -> "It's not yes."
    }
    description == "It's true!"
}

test tList(){
    let xs = [1,2]
    let x = when xs is{
        [] -> "Khong co gi"
        [_a] -> "Co mot so"
        [_a, _b] -> "Co 2 so"
        _other -> "Co nhieu so"
    }
    x == "Co 2 so"
}

test tListInList(){
    let xs = [[2], [4]]

    let x = when xs is{
        [[]] -> "List dau tien rong"
        [[], ..] -> "Trong list dau tien bi rong"
        [[4], ..] -> "Trong list dau tien co chua so 4"
        _other -> "Cac truong hop khac"
    }

    x == "Cac truong hop khac"
}

// 3. If - else

test tIf_else(){
    let some_bool = True
    if some_bool{
        True
    }else{
        False
    }
}

fn fibonnaci(n: Int) -> Int{
    if n == 0{
        0
    }else if n == 1{
        1
    }else{
        fibonnaci(n - 2) + fibonnaci(n - 1)
    }
}

test tFibonnaci(){
    fibonnaci(7) == 13
}

// 4. Phân tích các kiểu dữ liệu có sử dụng một cấu trúc dữ liệu có sẵn

test tAnalytics(){
    let u = (4, "Aiken")
    
    let (x, y) = u

    x == 4 && y == "Aiken"

}

type Hello{
    aiken: ByteArray
}

test tHello(){
    let hello = Hello { aiken: "Aiken" }
    let Hello { aiken } = hello
    aiken == "Aiken"
}

// 5. Gán tên cho một kiểu dữ liệu

test tAs(){
    let xs = [[1,2,3,4,5]]
    let u = when xs is{
        [[_ , ..] as inner_list] -> inner_list
        _other -> []
    }
    u == [1,2,3,4,5]
}

// Kết hợp giữa when .. is và if-else

test tCombine(){
    let xs = [1,1,3]
    let u = when xs is{
        [a,b,c] if a == b && b != c -> "oke"
        _ -> "no"
    }
    u == "oke"
}

// 7. Xử lý lỗi và Todo
fn test1() -> Int{
    todo @"Thieu kieu du lieu tra ve"
}

fn test2(opt: Option<a>) -> a{
    when opt is{
        Some(a) -> a
        None -> error @"Chua co logic xu ly"
    }
}

test tTodo(){
    let a = test1()
    a == 0
}

test tError(){
    let opt = None
    let u = test2(opt)
    u == None
}