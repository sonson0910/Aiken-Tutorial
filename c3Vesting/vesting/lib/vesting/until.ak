use aiken/interval.{Finite}
use aiken/list
use aiken/transaction.{Transaction, ValidityRange}
use vesting/constant.{VerificationKeyHash}

pub fn must_be_signed_by(
  transaction: Transaction,
  vk: VerificationKeyHash,
) -> Bool {
  list.has(transaction.extra_signatories, vk)
}

pub fn must_start_after(range: ValidityRange, lock_until) {
  when range.lower_bound.bound_type is {
    Finite(tx_earliest_time) -> lock_until <= tx_earliest_time
    _ -> False
  }
}

// test test1() {
//   must_start_after(interval.after(3), 4)
// }

test test2() {
  must_start_after(interval.after(3), 3)
}

test test3() {
  must_start_after(interval.after(5), 4)
}
