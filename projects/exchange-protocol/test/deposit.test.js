const { expect } = require("chai");
const { ethers } = require("hardhat");
const {string} = require("hardhat/internal/core/params/argumentTypes");
const web3 = require("web3");

describe("deposit", function () {
    it("deposit test--->", async function () {
        const [owner, addr1, addr2, addr3, addr4,addr5] = await ethers.getSigners();
        const USDT = await ethers.getContractFactory("USDT");

        const usdt = await USDT.deploy("USDT","USDT",owner.address,"100000000000000");

        await usdt.transfer(addr1.address,"1000000000");

        const deposit = await ethers.getContractFactory("Inputout");
        // constructor(address usdt_,address owner, address width)
        const intout = await deposit.deploy(usdt.address,owner.address,owner.address);
        await usdt.connect(addr1).approve(intout.address,"1000000000000000000");
        await intout.connect(addr1).widthdraw("100000000",ethers.utils.toUtf8Bytes(addr3.address));
        await intout.connect(addr1).widthdraw("100000000",ethers.utils.toUtf8Bytes(addr3.address));
        await intout.connect(addr1).widthdraw("100000000",ethers.utils.toUtf8Bytes(addr3.address));
        await intout.connect(addr1).widthdraw("100000000",ethers.utils.toUtf8Bytes(addr3.address));
        await intout.connect(addr1).widthdraw("100000000",ethers.utils.toUtf8Bytes(addr3.address));

        console.log("----outputs---->",await intout.getalloutputs())
        await intout.changestatus(addr1.address,addr4.address,0)
        await intout.changestatus(addr1.address,addr4.address,1)
        console.log("----outputs---->",await intout.getalloutputs())
    });
})