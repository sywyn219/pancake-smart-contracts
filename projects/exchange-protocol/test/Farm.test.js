const { expect } = require("chai");
const { ethers } = require("hardhat");
const {string} = require("hardhat/internal/core/params/argumentTypes");
const web3 = require("web3");

describe("Farm", function () {
    this.timeout(10000000) // all tests in this suite get 10 seconds before timeout

    it("Farm test--->", async function () {
        const [owner, addr1, addr2, addr3, addr4,addr5] = await ethers.getSigners();
        const ERC20 = await ethers.getContractFactory("MyERC20");
        const myERC20 = await ERC20.deploy("PNC","PNC",owner.address,"100000000000000000000000000");

        const Farm = await ethers.getContractFactory("Farm");
        const farm = await Farm.deploy(owner.address,owner.address,myERC20.address);

        await farm.addMining(1,{value:ethers.utils.parseEther("10")});
        console.log("owner balance-->",await owner.getBalance())
        console.log("farm balance--->",ethers.utils.formatEther(await farm.getBalance()));

        await  farm.widthDrawOwner()
        console.log("farm balance--->",ethers.utils.formatEther(await farm.getBalance()));

        console.log("pair--->",await farm.pair())

        await farm.addProxyAddr(addr1.address);
        console.log("pAddrs--->",await farm.pAddrs());
    });
})