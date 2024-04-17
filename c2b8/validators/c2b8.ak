use aiken/cbor
// Troubleshooting

// 1. Trace

test init(){
    let x = 2
    if x % 2 == 0{
        trace "is_even"
        True
    }else{
        trace "is_odd"
        False
    }
}

validator{
    fn troubleshooting(_datum: Data, _ctx: Data) -> Bool{
        trace "Aiken"
        True
    }
}

// 2. Toán tử ?


test init2(){
    let must_be_after = True
    let must_spend_token = False
    must_be_after? && must_spend_token?
}

fn num(){
    4
}

// 3. Chuẩn đoán CBOR

// (lam i_31
//   (lam i_32
//     (lam i_33
//       (force
//         [ [ [ i_2 i_32 ] (delay (con unit ())) ]
//           (delay
//             [ [ i_4 [ i_33 [ i_1 i_32 ] ] ]
//               [ [ [ i_31 i_31 ] [ i_0 i_32 ] ] i_33
//               ]
//             ]
//           )
//         ]
//       )
//     )
//   )
// )

// CBOR diagnostics

// 83010203 -> [1, 2, 3]

test tcbor(){
    // // Kiểu Int thành số nguyên CBOR
    // cbor.diagnostic(42) == @"42"

    // // Kiểu ByteArray thành chuỗi byte CBOR
    // cbor.diagnostic("foo") == @"h'666F6F'"

    // // Kiểu List thành mảng CBOR
    // cbor.diagnostic([1, 2, 3]) == @"[_ 1, 2, 3]"

    // // Kiểu Tuple thành mảng CBOR
    // cbor.diagnostic((1, 2)) == @"[_ 1, 2]"

    // // List các Tuple (2 phần tử) thành map CBOR
    // cbor.diagnostic([(1, #"ff")]) == @"{ 1: h'FF' }"

    // // 'Some' là constructor đầu tiên của Option → được gắn tag 121
    // cbor.diagnostic(Some(42)) == @"121([_ 42])"

    // 'None' là constructor thứ hai của Option → được gắn tag 122
    cbor.diagnostic(None) == @"122([])"
}