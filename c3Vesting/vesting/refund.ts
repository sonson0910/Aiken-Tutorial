import {
    Blockfrost,
    Data,
    Lucid,
    SpendingValidator,
    TxHash,
    fromHex,
    toHex,
    Redeemer,
    UTxO,
} from "https://deno.land/x/lucid@0.8.3/mod.ts";
import * as cbor from "https://deno.land/x/cbor@v1.4.1/index.js";

const lucid = await Lucid.new(
    new Blockfrost(
        "https://cardano-preview.blockfrost.io/api/v0",
        "previewA1icPDH9Z17gbzfyVvxVlgBAcHT5I1Mg"
    ),
    "Preview"
);

lucid.selectWalletFromSeed(await Deno.readTextFile("./owner.seed"));

// --- Supporting functions

async function readValidator(): Promise<SpendingValidator> {
    const validator = JSON.parse(await Deno.readTextFile("plutus.json")).validators[0];
    return {
        type: "PlutusV2",
        script: toHex(cbor.encode(fromHex(validator.compiledCode))),
    };
}

const Datum = Data.Object({
    lock_until: Data.BigInt, // this is POSIX time, you can check and set it here: https://www.unixtimestamp.com
    owner: Data.String, // we can pass owner's verification key hash as byte array but also as a string
    beneficiary: Data.String, // we can beneficiary's hash as byte array but also as a string
});

type Datum = Data.Static<typeof Datum>;

// --- Supporting functions

async function unlock(utxos: UTxO[], { from, using }: { from: SpendingValidator, using: Redeemer }): Promise<TxHash> {
    const tx = await lucid
        .newTx()
        .collectFrom(utxos, using)
        .addSigner(await lucid.wallet.address())
        .attachSpendingValidator(from)
        .complete();

    const signedTx = await tx
        .sign()
        .complete();

    return signedTx.submit();
}

async function main() {
    const ownerPublicKeyHash = lucid.utils.getAddressDetails(await lucid.wallet.address()).paymentCredential?.hash;
    const validator = await readValidator();
    const contractAddress = lucid.utils.validatorToAddress(validator);
    const scriptUTxOs = await lucid.utxosAt(contractAddress);

    const utxos = scriptUTxOs.filter((utxo) => {
        try {
            const datum = Data.from<Datum>(utxo.datum ?? '', Datum);
            console.log(datum)

            return datum.owner === ownerPublicKeyHash;
        } catch (e) {
            console.log(e);
            return false;
        }
    });

    if (utxos.length === 0) {
        console.log("No redeemable utxo found. You need to wait a little longer...");
        Deno.exit(1);
    }

    const redeemer = Data.empty();

    const txUnlock = await unlock(utxos, { from: validator, using: redeemer });

    await lucid.awaitTx(txUnlock);

    console.log(`1 tADA refund from the contract
        Tx ID: ${txUnlock}
        Redeemer: ${redeemer}
    `);
}

main();