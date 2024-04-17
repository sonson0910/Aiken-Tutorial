// Test

// 1. Orverview

test init(){
    let t = [1,2,4]
    when t is{
        [1, ..] -> True
        _ -> False
    }
}

// 2. Báo cáo thử nghiệm

fn add_one(n: Int) -> Int{
    n + 1
}

test add_one_1(){
    add_one(0) == 1
}

test add_one_2(){
    add_one(-41) == -40
}

// 3. Sự khác biệt giữa 2 bên khi biểu thức trả về là phép so sánh

test add_one_3(){
    add_one(1) == 1
}

// 4. Các câu lệnh chạy thử nghiệm trong terminal