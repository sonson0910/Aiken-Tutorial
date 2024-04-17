fn f1(){
    "Aiken"
}

fn f2(){
    "C2VN"
}

pub fn f1_f2_list(){
    [f1(), f2()]
}

test init(){
    f1_f2_list() == ["Aiken", "C2VN"]
}