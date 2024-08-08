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
} from "https://deno.land/x/lucid@0.8.3/mod.ts";
import * as cbor from "https://deno.land/x/cbor@v1.4.1/index.js";

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

const sellerPublicKeyHash = lucid.utils.getAddressDetails(
    await lucid.wallet.address()
).paymentCredential?.hash;

const authorPublicKeyHash = lucid.utils.getAddressDetails(
    "addr_test1qrna2qs0xqlwyugwjs4pzd3mqrmryp2svl7g487w4qhx8l9es2sp3hun44wsjcf0twqw452tzkscgw69ah0dmretmaus6nh8w2"
).stakeCredential?.hash;

const Datum = Data.Object({
    policyID: Data.String,
    assetName: Data.String,
    seller: Data.String,
    author: Data.String,
    price: Data.BigInt,
    royalties: Data.BigInt,
});

type Datum = Data.Static<typeof Datum>;

const Price = 100000000n;
const royalties = BigInt(Number(Price) * 1 / 100);
const policyID = "f78575ae686f541f321eab6cd917201cbef4662cc196629c9ff56459";
const assetName = "000de1404769726c"
const fee = royalties + BigInt(Number(Price) * 1 / 100);

const datum = Data.to<Datum>(
    {
        policyID: policyID,
        assetName: assetName,
        seller: sellerPublicKeyHash??"",
        author: authorPublicKeyHash??"",
        price: Price,
        royalties: royalties,
    },
    Datum
);

const NFT = policyID + assetName;
console.log("NFT: " + NFT);

async function lockNFT(NFT: string, fee: bigint, { validator, datum } : { validator: SpendingValidator, datum: string}): Promise<TxHash> {
    const contractAddress = lucid.utils.validatorToAddress(validator);

    const tx = await lucid.newTx()
        .payToContract(contractAddress, { inline: datum }, { [NFT]: 1n, lovelace: fee })
        .complete();
    
    const signedTx = await tx.sign().complete();

    return signedTx.submit();
} 

const txLock = await lockNFT(NFT, fee, { validator: validator, datum: datum });

console.log(`TxHash: ${txLock}`);                                                                    