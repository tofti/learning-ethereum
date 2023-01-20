const ethers = require("ethers");
const fs = require("fs-extra");

async function main() {
    //console.log('hi')
    const provider = new ethers.providers.JsonRpcProvider("http://127.0.0.1:7545");

    const network = await provider.send("eth_chainId");
    console.log(`Network ${parseInt(16,network)}`);

    const wallet = new ethers.Wallet("83d4107c13bc4213816ec83b51946572e943a88ea0221947d429d6708a45f94b", provider);

    const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf-8");
    const bin = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.bin", "utf-8");
    
    const contractFactory = new ethers.ContractFactory(abi, bin, wallet);
    
    console.log("Deploying...");
    const contract = await contractFactory.deploy();
    await contract.deployTransaction.wait(1);

    /*
    send a raw tx
    const tx = {
        nonce: 4,
        gasPrice: 20000000000,
        gasLimit: 1000000,
        to: null,
        value: 0,
        data: `0x${bin}`,
        chainId: 1337
    }
    sendTxResponse = await wallet.sendTransaction(tx);
    await sendTxResponse.wait(1);
    */

    let favNumber = await contract.retrieve();
    console.log("favNumber", favNumber.toString());
    
    const storeResponse = await contract.store("7");
    const storeReponseReceipt = storeResponse.wait(1);    
    
    favNumber = await contract.retrieve();
    console.log("favNumber", favNumber.toString());
    
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })