use aiken/hash.{Blake2b_224, Hash}
use aiken/list
use aiken/string
use aiken/transaction.{ScriptContext, OutputReference, TransactionId, Spend, Transaction}
use aiken/transaction/credential.{VerificationKey}

type Datum{
    owner: Hash<Blake2b_224, VerificationKey>,
}

type Redeemer{
    message: ByteArray,
}

validator{
    fn helloworld(datum:Datum, redeemer:Redeemer, ctx: ScriptContext) -> Bool {
        let must_say_hello = redeemer.message == "Hello world!"
        trace string.from_bytearray(redeemer.message)

        let must_be_signed = list.has(ctx.transaction.extra_signatories, datum.owner)

        must_say_hello? && must_be_signed?
    }
}

test helloworldExample(){
    let datum = Datum { owner: #"00000000000000000000000000000000000000000000000000000000" }
    let datum1 = Datum { owner: #"00000000000000000000000000000000000000000000000000000000" }

    let redeemer = Redeemer { message: "Hello world!" }

    let ctx = 
        ScriptContext{
            purpose: Spend(
                OutputReference { transaction_id: TransactionId(""), output_index: 0 }
            ),
            transaction: transaction.placeholder()
                |> fn(transaction){
                    Transaction { ..transaction, extra_signatories: [datum.owner] }
                }
        }
    
    helloworld(datum1, redeemer, ctx)
}