const { expect } = require("chai");
const { ethers } = require("hardhat");
const {string} = require("hardhat/internal/core/params/argumentTypes");
const web3 = require("web3");

describe("Swap", function () {
    it("Swap test--->", async function () {

        const [owner, addr1, addr2, addr3, addr4,addr5] = await ethers.getSigners();
        console.log("owner--->",owner.address)
        const USDT = await ethers.getContractFactory("USDT");
        //
        const usdt = await USDT.deploy("USDT","USDT",owner.address,"1000000000000000");
        console.log("usdt--->",usdt.address)

        const WBNB = await ethers.getContractFactory("WBNB");
        const wbnb = await WBNB.deploy();
        console.log("wbnb--->",wbnb.address, await wbnb.name())

        const PancakeFactory = await ethers.getContractFactory("PancakeFactory");
        const pancakeFactory = await PancakeFactory.deploy(owner.address);
        await pancakeFactory.setFeeTo(owner.address);
        console.log("pancakeFactory--->",pancakeFactory.address,"INIT_CODE_PAIR_HASH-->",
            await pancakeFactory.INIT_CODE_PAIR_HASH(),"feeTo",await pancakeFactory.feeTo())

        const PancakeRouter01 = await ethers.getContractFactory("PancakeRouter01");
        const pancakeRouter01 = await PancakeRouter01.deploy(pancakeFactory.address,wbnb.address);
        console.log("pancakeRouter01--->",pancakeRouter01.address);

        const PancakeRouter = await ethers.getContractFactory("PancakeRouter");
        const pancakeRouter = await PancakeRouter.deploy(pancakeFactory.address,wbnb.address)
        console.log("pancakeRouter--->",pancakeRouter.address)

        const MultiCall = await ethers.getContractFactory("Multicall");
        const multiCall = await MultiCall.deploy();
        console.log("multiCall--->",multiCall.address)
    });
});