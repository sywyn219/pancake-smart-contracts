const { ethers, upgrades } = require("hardhat");

async function main() {
    console.log("------")
    const [owner] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", owner.address);

    const PancakeFactory = await ethers.getContractFactory("PancakeFactory");
    // const pancakeFactoryAtt = await PancakeFactory.attach("0xea4D277737eFe07b4358E3F57D7BfFd79C353aD1")
    // console.log("feeTo",await pancakeFactoryAtt.feeTo())
    // return
    const pancakeFactory = await PancakeFactory.deploy(owner.address);
    await pancakeFactory.setFeeTo(owner.address);

    console.log("pancakeFactory--->",pancakeFactory.address,"INIT_CODE_PAIR_HASH-->",
        await pancakeFactory.INIT_CODE_PAIR_HASH(),"feeTo",await pancakeFactory.feeTo())

    const USDT = await ethers.getContractFactory("USDT");
    //
    const usdt = await USDT.deploy("USDT","USDT",owner.address,"1000000000000000");
    console.log("usdt--->",usdt.address)

    const WBNB = await ethers.getContractFactory("WBNB");
    const wbnb = await WBNB.deploy();
    console.log("wbnb--->",wbnb.address, await wbnb.name())

    const PancakeRouter01 = await ethers.getContractFactory("PancakeRouter01");
    const pancakeRouter01 = await PancakeRouter01.deploy(pancakeFactory.address,wbnb.address);
    console.log("pancakeRouter01--->",pancakeRouter01.address);

    const PancakeRouter = await ethers.getContractFactory("PancakeRouter");
    const pancakeRouter = await PancakeRouter.deploy(pancakeFactory.address,wbnb.address)
    console.log("pancakeRouter--->",pancakeRouter.address)

    const MultiCall = await ethers.getContractFactory("Multicall");
    const multiCall = await MultiCall.deploy();
    console.log("multiCall--->",multiCall.address)

}



// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });