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
} from "https://deno.land/x/lucid@0.8.4/mod.ts";
import * as cbor from "https://deno.land/x/cbor@v1.4.1/index.js";

const lucid = await Lucid.new(
    new Blockfrost(
        "https://cardano-preview.blockfrost.io/api/v0",
        "previewARFMNonNUcS6QxrekGoh9XvqWpuyXehe",
    ),
    "Preview",
);

const wallet = lucid.selectWalletFromSeed(await Deno.readTextFile("./buyer.seed"));

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

const policyID = "f78575ae686f541f321eab6cd917201cbef4662cc196629c9ff56459";
const assetName = "000de1404769726c"

let UTxOOut: any;

const scriptUTxO = await lucid.utxosAt(scriptAddress);

const utxos = scriptUTxO.filter((utxo) => {
    try {
        const temp = Data.from<Datum>(utxo.datum ?? "", Datum);

        if (temp.policyID === policyID && temp.assetName === assetName) {
            UTxOOut = Data.from<Datum>(utxo.datum ?? "", Datum);;
            return true;
        }
        return false;
    } catch (e) {
        return false;
    }
});
console.log(UTxOOut);

console.log(utxos);

if (utxos.length === 0) {
    console.log("NFT not found");
    Deno.exit(1);
}

const exchange_fee = BigInt(Number(UTxOOut.price) * 1 / 100);

const redeemer = Data.void();

async function unlockNFT(utxos: UTxO[], UTxOOut: Datum, exchange_fee: bigint, { validator, redeemer }: { validator: SpendingValidator, redeemer: string }): Promise<TxHash> {
    const tx = await lucid
        .newTx()
        .payToAddress("addr_test1qpkxr3kpzex93m646qr7w82d56md2kchtsv9jy39dykn4cmcxuuneyeqhdc4wy7de9mk54fndmckahxwqtwy3qg8pums5vlxhz", { lovelace: UTxOOut.price })
        .payToAddress("addr_test1qrna2qs0xqlwyugwjs4pzd3mqrmryp2svl7g487w4qhx8l9es2sp3hun44wsjcf0twqw452tzkscgw69ah0dmretmaus6nh8w2", { lovelace: UTxOOut.royalties })
        .payToAddress("addr_test1qqayue6h7fxemhdktj9w7cxsnxv40vm9q3f7temjr7606s3j0xykpud5ms6may9d6rf34mgwxqv75rj89zpfdftn0esq3pcfjg", { lovelace: exchange_fee })
        .collectFrom(utxos, redeemer)
        .attachSpendingValidator(validator)
        .complete();
    
    const signedTx = await tx.sign().complete();

    return signedTx.submit();
}

const txUnlock = await unlockNFT(utxos, UTxOOut, exchange_fee, { validator: validator, redeemer: redeemer });

await lucid.awaitTx(txUnlock);

console.log(`TxHash: ${txUnlock}`);