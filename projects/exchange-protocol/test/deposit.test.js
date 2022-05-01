const { expect } = require("chai");
const { ethers } = require("hardhat");
const {string} = require("hardhat/internal/core/params/argumentTypes");
const web3 = require("web3");

describe("deposit", function () {
    this.timeout(10000000) // all tests in this suite get 10 seconds before timeout

    it("deposit test--->", async function () {
        const [owner, addr1, addr2, addr3, addr4,addr5] = await ethers.getSigners();
        const USDT = await ethers.getContractFactory("USDT");

        const usdt = await USDT.deploy("USDT","USDT",owner.address,"1000000000000000");

        await usdt.transfer(addr1.address,"1000000000000000");


        const deposit = await ethers.getContractFactory("Inputout");
        // constructor(address usdt_,address owner, address width)
        const intout = await deposit.deploy(usdt.address,owner.address,owner.address);
        await usdt.connect(addr1).approve(intout.address,"1000000000000000");

        // for (let i=0;i<1000;i++) {
        //     console.log("--------------------",i)
            await intout.connect(addr1).widthdraw("10000000",ethers.utils.base58.decode("TKDFFDyoyb7QKorZKjFH1Yv14vAYdNTohu"));
            await intout.connect(addr1).widthdraw("10000000",ethers.utils.base58.decode("TKDFFDyoyb7QKorZKjFH1Yv14vAYdNTohu"));
            await intout.connect(addr1).widthdraw("10000000",ethers.utils.base58.decode("TKDFFDyoyb7QKorZKjFH1Yv14vAYdNTohu"));
            await intout.connect(addr1).widthdraw("10000000",ethers.utils.base58.decode("TKDFFDyoyb7QKorZKjFH1Yv14vAYdNTohu"));
            await intout.connect(addr1).widthdraw("10000000",ethers.utils.base58.decode("TKDFFDyoyb7QKorZKjFH1Yv14vAYdNTohu"));
        // }

        await intout.changeStatus(addr1.address,addr4.address,0)
        await intout.changeStatus(addr1.address,addr4.address,1)
        // console.log("----outputs---->",await intout.getalloutputs())
        console.log("----outputs---->",await intout.outputsall(3))

        console.log("--------index------->",ethers.utils.base58.encode((await intout.getAllOutputsIndex(1,1))[0].toaddr))
    });
})