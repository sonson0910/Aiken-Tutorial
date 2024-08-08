import {
    Blockfrost,
    C,
    Data,
    Lucid,
    SpendingValidator,
    TxHash,
    fromHex,
    toHex,
    Wallet,
    UTxO
} from "https://deno.land/x/lucid@0.8.3/mod.ts";
import * as cbor from "https://deno.land/x/cbor@v1.4.1/index.js";
import { ConstrPlutusData } from "https://deno.land/x/lucid@0.8.3/src/core/wasm_modules/cardano_multiplatform_lib_nodejs/cardano_multiplatform_lib.js";

const lucid = await Lucid.new(
    new Blockfrost(
        "https://cardano-preview.blockfrost.io/api/v0",
        "previewARFMNonNUcS6QxrekGoh9XvqWpuyXehe",
    ),
    "Preview",
);

const wallet = lucid.selectWalletFromSeed(await Deno.readTextFile("./seller.seed"));

async function readValidator(): Promise<SpendingValidator> {
    const validator = JSON.parse(await Deno.readTextFile("plutus.json")).validators[0];
    return {
        type: "PlutusV2",
        script: toHex(cbor.encode(fromHex(validator.compiledCode))),
    };
}

const validator = await readValidator();

const scriptAddress = lucid.utils.validatorToAddress(validator);

const Datum = Data.Object({
    policyID: Data.String,
    assetName: Data.String,
    seller: Data.String,
    author: Data.String,
    price: Data.BigInt,
    royalties: Data.BigInt,
});

type Datum = Data.Static<typeof Datum>;

const policyID = "7e6cc024f5bf0327c39d411974553b34bf0ddfd481a332c695c112fc";
const assetName = "000de1406769726c"


const scriptUTxO = await lucid.utxosAt(scriptAddress);

const utxos = scriptUTxO.filter((utxo) => {
    try {
        const temp = Data.from<Datum>(utxo.datum ?? "", Datum);

        if (temp.policyID === policyID && temp.assetName === assetName) {
            return true;
        }
        return false;
    } catch (e) {
        return false;
    }
});

console.log(utxos);

if (utxos.length === 0) {
    console.log("NFT not found");
    Deno.exit(1);
}


const redeemer = Data.empty();

async function unlockNFT(utxos: UTxO[], { validator, redeemer }: { validator: SpendingValidator, redeemer: string }): Promise<TxHash> {
    const tx = await lucid
        .newTx()
        .collectFrom(utxos, redeemer)
        .addSigner(await lucid.wallet.address())
        .attachSpendingValidator(validator)
        .complete();

    const signedTx = await tx.sign().complete();

    return signedTx.submit();
}

const txUnlock = await unlockNFT(utxos, { validator: validator, redeemer: redeemer });

await lucid.awaitTx(txUnlock);

console.log(`TxHash: ${txUnlock}`);