// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;


interface IERC20 {
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);
}


// helper methods for interacting with ERC20 tokens and sending ETH that do not consistently return true/false
library TransferHelper {
    function safeApprove(address token, address to, uint value) internal {
        // bytes4(keccak256(bytes('approve(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x095ea7b3, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: APPROVE_FAILED');
    }

    function safeTransfer(address token, address to, uint value) internal {
        // bytes4(keccak256(bytes('transfer(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FAILED');
    }

    function safeTransferFrom(address token, address from, address to, uint value) internal {
        // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x23b872dd, from, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FROM_FAILED');
    }

    function safeTransferETH(address to, uint value) internal {
        (bool success,) = to.call{value:value}(new bytes(0));
        require(success, 'TransferHelper: ETH_TRANSFER_FAILED');
    }
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}


contract Inputout is Ownable {

    struct TxInput {
        bytes from;
        bytes txid;
        address toaddr;
        uint256 value;
        uint256 times;
    }

    struct TxOut {
        bytes txid;
        uint256 nonce;
        address fromaddr;
        bytes toaddr;
        uint256 status;
        uint256 value;
        uint256 times;
    }

    mapping(address => TxInput[])  public inputs;
    TxInput[] public inputsall;

    mapping(address => TxOut[]) public outputs;
    TxOut[] public outputsall;


    address public usdt;

    address public widthaddr;

    constructor(address usdt_,address owner, address width) public {
        usdt = usdt_;
        transferOwnership(owner);
        widthaddr = width;
    }


    function deposit(uint256 value,bytes memory  from,bytes memory txid,address toaddr) public{
        require(value > 0,"value must be greater than 0");
        require(toaddr != address(0),"zero addrs");

        TransferHelper.safeTransferFrom(usdt, msg.sender, toaddr, value);

        TxInput memory txin = TxInput(from,txid,toaddr,value,block.timestamp);
        inputs[toaddr].push(txin);
        inputsall.push(txin);
    }

    function widthdraw(uint256 value,bytes memory toaddr) public{
        require(value > 0,"value must be greater than 0");
        require(toaddr.length != 0,"addr is nil");

        TransferHelper.safeTransferFrom(usdt, msg.sender, widthaddr, value);

        TxOut memory txout = TxOut("",outputsall.length,msg.sender,toaddr,0,value,block.timestamp);
        outputs[msg.sender].push(txout);
        outputsall.push(txout);
    }

    function changeStatus(address from,bytes memory txid,uint256 nonce) public onlyOwner{
        for (uint i=0; i< outputs[from].length;i++) {
            if (outputs[from][i].nonce == nonce) {
                outputs[from][i].txid = txid;
                outputs[from][i].status = 1;
            }
        }
        outputsall[nonce].txid = txid;
        outputsall[nonce].status = 1;
    }

    function setWidthaddr(address newWidth) public onlyOwner {
        widthaddr = newWidth;
    }

    function setUsdt(address usdt_) public onlyOwner {
        usdt = usdt_;
    }

    function getInputsAddr(address addr) public view returns (TxInput[] memory) {
        return inputs[addr];
    }

    function getOutputsAddr(address addr) public view returns (TxOut[] memory) {
        return outputs[addr];
    }

    function getAllinputs() public view returns(TxInput[] memory) {
        return inputsall;
    }

    function getAlloutputs() public view returns(TxOut[] memory) {
        return outputsall;
    }

    function inputsallLen() public view returns(uint256) {
        return inputsall.length;
    }

    function outputsallLen() public view returns(uint256) {
        return outputsall.length;
    }

    function getAllOutputsIndex(uint256 start,uint256 total) public view returns(TxOut[] memory) {
        TxOut[] memory txs;
        if (outputsall.length < start) {
            return txs;
        }
        if (total > start) {
            return txs;
        }

        txs = new TxOut[](total);
        for (uint i=0; i<total; i++){
            txs[i] = outputsall[start-i-1];
        }

        return txs;
    }

    function getAllInputsIndex(uint256 start,uint256 total) public view returns(TxInput[] memory) {
        TxInput[] memory txs;
        if (inputsall.length < start) {
            return txs;
        }
        if (total > start) {
            return txs;
        }

        txs = new TxInput[](total);
        for (uint i=0; i<total; i++){
            txs[i] = inputsall[start-i-1];
        }

        return txs;
    }


}
