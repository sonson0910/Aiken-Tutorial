pub opaque type Counter{
    Counter(Int)
}

pub fn new(){
    Counter(0)
}

pub fn increment(counter: Counter){
    let Counter(x) = counter
    Counter(x + 1)
}