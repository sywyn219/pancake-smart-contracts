const { ethers, upgrades } = require("hardhat");

async function main() {

    const PancakeRouter = await ethers.getContractFactory("PancakeRouter");
    const pancakeRouter = await PancakeRouter.attach("0xB0703c64C78826c80A0F46C71eba017DdB2ff3a7");

    const factoryAddr = await pancakeRouter.factory()
    console.log("factoryAddr--->",factoryAddr);


    const PancakeFactory = await ethers.getContractFactory("PancakeFactory");
    const pancakeFactoryAtt = await PancakeFactory.attach("0xea4D277737eFe07b4358E3F57D7BfFd79C353aD1")

    console.log("Pair",await pancakeFactoryAtt.getPair("0x2a117B6DD140E5C43dAFEB2283Da98b02deF1711","0xE262D1122aFcd9be4411dC3162FE44fd3987d259"))
    console.log("allPair",await  pancakeFactoryAtt.allPairs(1))


    const PancakePair = await ethers.getContractFactory("PancakePair");
    const pair = await PancakePair.attach("0x43ac951B4bFF38E91e6e35eA15B2912836065A82");
    const [token0,token1,times] = await pair.getReserves()
    console.log("----pair",ethers.utils.formatEther(token0,18),ethers.utils.formatUnits(token1,6))
    console.log("----token balance",token1.mul(ethers.utils.parseUnits("0.000001")).div(token0))
    return


    const [owner] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", owner.address);

    const USDT = await ethers.getContractFactory("USDT");
    //
    const usdt = await USDT.deploy("USDT","USDT",owner.address,"1000000000000000000000000000");
    console.log("usdt--->",usdt.address)
    return

    const Multicall2 = await ethers.getContractFactory("Multicall2");
    const multiCall2 = await Multicall2.deploy();
    console.log("multiCall2--->",multiCall2.address)



    // const pancakeFactoryAtt = await PancakeFactory.attach("0xea4D277737eFe07b4358E3F57D7BfFd79C353aD1")
    // console.log("feeTo",await pancakeFactoryAtt.feeTo())
    // return
    const pancakeFactory = await PancakeFactory.deploy(owner.address);
    await pancakeFactory.setFeeTo(owner.address);

    console.log("pancakeFactory--->",pancakeFactory.address,"INIT_CODE_PAIR_HASH-->",
        await pancakeFactory.INIT_CODE_PAIR_HASH(),"feeTo",await pancakeFactory.feeTo())



    const WBNB = await ethers.getContractFactory("WBNB");
    const wbnb = await WBNB.deploy();
    console.log("wbnb--->",wbnb.address, await wbnb.name())

    const PancakeRouter01 = await ethers.getContractFactory("PancakeRouter01");
    const pancakeRouter01 = await PancakeRouter01.deploy(pancakeFactory.address,wbnb.address);
    console.log("pancakeRouter01--->",pancakeRouter01.address);


    // const pancakeRouter = await PancakeRouter.deploy(pancakeFactory.address,wbnb.address)
    // console.log("pancakeRouter--->",pancakeRouter.address)

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