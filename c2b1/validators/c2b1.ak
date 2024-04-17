use aiken/string

test init(){
    let a = True
    let b = False
    !(a == b) && (1 + 1 > 2)
}

test checkInt(){
    1000000 == 1_000_000
}

test checkByteArray(){
    #"666f6f" == #"666f6f"
}

test checkTuple(){
    let point = (2,3)
    let x = point.1st
    let y = point.2nd
    x + 1 == y
}

test checkList(){
    let x = [6,7]
    let y = [5,..x]
    y == [5,6,7]
}

test nana(){
    let x = 2
    let x = 3
    x == 3
}

validator{
    fn sell(_datum: Void, _ctx: Void) -> Bool{
        True
    }
}