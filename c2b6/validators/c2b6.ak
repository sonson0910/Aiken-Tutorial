// Module

// 1. Module
// 2. Import
use c2b6/until.{f1_f2_list}
use aiken/string


fn f3(){
    when f1_f2_list() is{
        [a, ..] if a == "Aiken" -> "oke"
        _ -> "other"
    }
}

test tF3(){
    f3() == "oke"
}

// 3. Từ khóa opaque
// 4. Module aiken co san

test tConcat(){
    let str1 = @"Aiken"
    let str2 = @" tutorial!"
    string.concat(str1, str2) == @"Aiken tutorial!"
}

// 5. Builtin

use aiken/builtin

fn eq(a, b){
    builtin.equals_integer(a, b) // a == b
}

test tBuiltin(){
    eq(1,2) == False
}