use aiken/transaction.{ScriptContext, Spend, Transaction}
use vesting/constant.{POSIXTime, VerificationKeyHash}
use vesting/until.{must_be_signed_by, must_start_after}

type Datum {
  lock_until: POSIXTime,
  owner: VerificationKeyHash,
  benificiary: VerificationKeyHash,
}

validator {
  fn vesting(datum: Datum, _redeemer: Void, ctx: ScriptContext) -> Bool {
    when ctx.purpose is {
      Spend(_) -> or {
          must_be_signed_by(ctx.transaction, datum.owner),
          and {
            must_be_signed_by(ctx.transaction, datum.benificiary),
            must_start_after(ctx.transaction.validity_range, datum.lock_until),
          },
        }
      _ -> False
    }
  }
}
