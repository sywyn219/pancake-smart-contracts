// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface IPancakePair {
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

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

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint256);

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    event Mint(address indexed sender, uint256 amount0, uint256 amount1);
    event Burn(address indexed sender, uint256 amount0, uint256 amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint256 amount0In,
        uint256 amount1In,
        uint256 amount0Out,
        uint256 amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint256);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
    external
    view
    returns (
        uint112 reserve0,
        uint112 reserve1,
        uint32 blockTimestampLast
    );

    function price0CumulativeLast() external view returns (uint256);

    function price1CumulativeLast() external view returns (uint256);

    function kLast() external view returns (uint256);

    function mint(address to) external returns (uint256 liquidity);

    function burn(address to) external returns (uint256 amount0, uint256 amount1);

    function swap(
        uint256 amount0Out,
        uint256 amount1Out,
        address to,
        bytes calldata data
    ) external;

    function skim(address to) external;

    function sync() external;

    function initialize(address, address) external;
}

// OpenZeppelin Contracts v4.4.1 (utils/math/SafeMath.sol)
// CAUTION
// This version of SafeMath should only be used with Solidity 0.8 or later,
// because it relies on the compiler's built in overflow checks.
/**
 * @dev Wrappers over Solidity's arithmetic operations.
 *
 * NOTE: `SafeMath` is generally not needed starting with Solidity 0.8, since the compiler
 * now has built in overflow checking.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
    unchecked {
        uint256 c = a + b;
        if (c < a) return (false, 0);
        return (true, c);
    }
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
    unchecked {
        if (b > a) return (false, 0);
        return (true, a - b);
    }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
    unchecked {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) return (true, 0);
        uint256 c = a * b;
        if (c / a != b) return (false, 0);
        return (true, c);
    }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
    unchecked {
        if (b == 0) return (false, 0);
        return (true, a / b);
    }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
    unchecked {
        if (b == 0) return (false, 0);
        return (true, a % b);
    }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
    unchecked {
        require(b <= a, errorMessage);
        return a - b;
    }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
    unchecked {
        require(b > 0, errorMessage);
        return a / b;
    }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
    unchecked {
        require(b > 0, errorMessage);
        return a % b;
    }
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
//        _transferOwnership(address(0));
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

contract Farm is Ownable{

    using SafeMath for uint256;

    constructor(address owner,address widthDr,address pnc_){
        pair = IPancakePair(0x43ac951B4bFF38E91e6e35eA15B2912836065A82);
        widthAddr = widthDr;
        pncAddr = pnc_;
        transferOwnership(owner);
        sale.push(100 ether);
        sale.push(500 ether);
        sale.push(1000 ether);
    }

    uint256 public accountNums = 10000;

    //总消费
    uint256 public totalAmount = 1;

    //
    struct Mining {
        uint256 blockAmount;
        uint256 blockStart;
        uint256 blockEnd;
    }

    //用户
    struct User {
        address addr;
        uint256 refAccount;
        uint256 amount; //消费金额
        uint256 startBlock;
    }

    //总代理开立
    struct ProxyAccount {
        uint256 account;
        address refAddr; //指向地址
        address addr;
        uint256 totalCoin; //总业绩
        uint256 invites; //邀请用户数
    }

    //管理员开立
    struct ProxyAddr {
        uint256 accs;//帐号
        address addr; //地址
        uint256 totalInvite; //总邀请
        uint256 totalCoin; //总业绩
        uint256 balance;//可提现
    }

    //用户开立
    struct ProxyUser {
        address addr;
        uint256 account;
        uint256 totalCoin; //总业绩
        uint256 totalInvite; //总邀请
        uint256 balance;//可提现
    }

    struct WidthBalance {
        uint256 nonce;
        address addr;
        uint256 balance;
        uint256 status;
    }



    uint256 public dayNums = 6171;
    uint256 public ratePNC = 20;
    address public pncAddr;

    IPancakePair public pair;

    uint256 public decimalUSDT=1000000000000;

    uint256 public level0 = 0;
    uint256 public levelRate0 = 5;

    uint256 public level1 = 500 ether;
    uint256 public levelRate1 = 30;

    uint256 public level2 = 1000 ether;
    uint256 public levelRate2 = 40;

    uint256 public level3 = 1001 ether;
    uint256 public levelRate3 = 50;


    //销售单位
    uint256[] public sale;

    address public widthAddr;


    mapping(address => User) public users;
    address[] public pUsers;

    mapping(uint256 => address) public accToAddr;

    mapping(address => ProxyAccount) public accounts;
    address[] public pAccounts;

    mapping(address => ProxyAddr) public addrs;
    address[] public pAddrs;


    mapping(address => ProxyUser) public pUser;
    address[] public pUserAddrs;


    WidthBalance[] public withdrawalBalance;
    Mining[] public minings;


    function getSale() public view returns(uint256[] memory) {
        return sale;
    }

    function getPUsers() public view returns(address[] memory) {
        return pUsers;
    }

    function getPAccounts() public view returns(address[] memory) {
        return pAccounts;
    }

    function getPAddrs() public view returns(address[] memory) {
        return pAddrs;
    }

    function getPUserAddrs() public view returns(address[] memory) {
        return pUserAddrs;
    }

    function getWithdrawlBalance() public view returns(WidthBalance[] memory) {
        return withdrawalBalance;
    }

    function getMining() public view returns(Mining[] memory) {
        return minings;
    }

    function addProxyAddr(address addr) public onlyOwner {
        require(addrs[addr].addr == address(0),"addr is proxy");

        accountNums = accountNums + 300;

        ProxyAddr memory pa= ProxyAddr(accountNums,addr,0,0,0);
        addrs[addr] = pa;
        pAddrs.push(addr);
    }

    function addAccount(uint256 acc,address addr) public {
        require(addrs[msg.sender].addr == msg.sender,"must proxy addr");
        require(isProxyAcc(acc,msg.sender), "acc must in accs");
        require(accToAddr[acc] == address(0),"acc already");
        require(accounts[addr].account == 0, "addr already");

        ProxyAccount memory pa = ProxyAccount(acc,msg.sender,addr,0,0);
        accounts[pa.addr] = pa;
        pAccounts.push(addr);
        accToAddr[acc] = addr;
    }

    function isProxyAcc(uint256 acc,address addr) public view returns(bool) {
            for (uint i= addrs[addr].accs;i < addrs[addr].accs+200;i+=10) {
                if (acc == i) {
                    return true;
                }
            }
        return false;
    }

    function addMining(uint256 day) public payable {
        require(msg.value >= 100000000000000000,"value zero");
        require(day >= 1,"days less zero");
        require(totalAmount >0,"total amount is zero");

        uint256 endBlock = day*dayNums;
        uint256 avgBlockAmount = msg.value.div(endBlock);
        uint256 blockAmount = avgBlockAmount.div(totalAmount);

        require(blockAmount > 0,"avgAmount than zero");

        Mining memory min = Mining(blockAmount,block.number,block.number+endBlock);
        minings.push(min);
    }

    function buy(uint inx,uint nums,uint256 refAcc) public payable {
        require(refAcc != 0, "ref account is zero");
        require(accToAddr[refAcc] != address(0),"ref addr is zero");
        require(inx < sale.length,"inx out sale length");
        uint256 amount = sale[inx].mul(nums);
        require(msg.value >= amount,"amount is less");

        payable(widthAddr).transfer(msg.value);

        //结算之前的产币
        widthDrawHSO();

        User memory u = users[msg.sender];
        if (u.addr != msg.sender) {
            u.addr = msg.sender;
            u.refAccount = refAcc;
            pUsers.push(msg.sender);
        }
        u.amount = u.amount.add(amount);
        users[msg.sender] = u;

        address accAddr = accToAddr[refAcc];

        (uint256 token0,uint256 token1,) = pair.getReserves();
        uint256 price = token1.mul(decimalUSDT).div(token0);

        //检查是否存在上级代理并更新代理数据
        bool isAcc = updateProxyAddr(accAddr,price,amount);

        //不是代理，即是普通用户推荐
        if (!isAcc) {
            ProxyUser memory pu =  pUser[accAddr];
            pu.totalCoin = pu.totalCoin.add(amount);
            pu.totalInvite = pu.totalInvite.add(1);

            uint256 amt = amount.div(100).mul(levelRate0);
            uint256 balance = amt.mul(price);
            pu.balance = pu.balance.add(balance);
            pUser[accAddr] = pu;
        }

        //检查并开立普通用户推荐码
        if (pUser[msg.sender].addr == address(0)) {
            pUser[msg.sender].addr = msg.sender;
            accountNums = accountNums + 300;
            pUser[msg.sender].account = accountNums;
            accToAddr[accountNums] = msg.sender;
            pUserAddrs.push(msg.sender);
        }

        //更新全局总销售额
        totalAmount = totalAmount.add(amount);
    }

    // 获取合约账户余额
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
    function widthDrawOwner() public onlyOwner {
        uint balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

    //用户提产币
    function widthDrawHSO() public{
        uint256 amount = calcMiningAmount(msg.sender);
        users[msg.sender].startBlock = block.number + 1;

        if (amount == 0) {
            return;
        }

        uint256 pnc = amount.div(100).mul(ratePNC);
        uint256 amt = amount - pnc;
        payable(msg.sender).transfer(amt);

        TransferHelper.safeTransferFrom(pncAddr,address(this), msg.sender, pnc);
    }

    //代理提款
    function withBalance() public {
        require(addrs[msg.sender].addr == msg.sender,"proxy addr is zero");
        require(addrs[msg.sender].balance > 0, "balance must than zero");

        WidthBalance memory wb = WidthBalance(withdrawalBalance.length,msg.sender,addrs[msg.sender].balance,0);
        withdrawalBalance.push(wb);
        addrs[msg.sender].balance = 0;
    }

    //普通代理提款
    function withUserBalance() public {
        require(pUser[msg.sender].addr == msg.sender,"proxy addr is zero");
        require(pUser[msg.sender].balance > 0, "balance must than zero");

        WidthBalance memory wb = WidthBalance(withdrawalBalance.length,msg.sender,pUser[msg.sender].balance,0);
        withdrawalBalance.push(wb);
        pUser[msg.sender].balance = 0;
    }

    function updateWithDrawBalance(uint256 nc) public onlyOwner {
        require(withdrawalBalance.length > nc,"withdrawbalance out of index");
        withdrawalBalance[nc].status = 1;
    }

    function calcMiningAmount(address addr) public view returns(uint256){
        User memory u = users[addr];

        if (u.amount == 0) {
            return 0;
        }
        if (u.startBlock > block.number) {
            return 0;
        }

        uint minAmount = 0;
        for (uint i=0; i < minings.length; i++) {
            if (minings[i].blockEnd <= block.number) {
                continue;
            }

            uint256 min = minings[i].blockAmount.mul(u.amount);
            uint256 minBlock = block.number.sub(u.startBlock);
            uint256 minBlockAmount = minBlock.mul(min);

            minAmount =  minAmount + minBlockAmount;
        }

        return minAmount;
    }

    function updateProxyAddr(address accAddr,uint256 price,uint256 amount) internal returns(bool){

        if (accounts[accAddr].addr == address(0) || accounts[accAddr].refAddr == address(0)) {
            return false;
        }

        accounts[accAddr].invites = accounts[accAddr].invites + 1;
        accounts[accAddr].totalCoin = accounts[accAddr].totalCoin.add(amount);

        ProxyAddr memory pAddr = addrs[accounts[accAddr].refAddr];
        pAddr.totalCoin = pAddr.totalCoin.add(amount);
        pAddr.totalInvite = pAddr.totalInvite.add(1);

        uint256 amt = 0;
        if (pAddr.totalCoin > level1) {
            amt = amount.div(100).mul(levelRate1);
        }
        if (pAddr.totalCoin > level2) {
            amt = amount.div(100).mul(levelRate2);
        }
        if (pAddr.totalCoin > level3) {
            amt = amount.div(100).mul(levelRate3);
        }

        uint256 balance = amt.mul(price);
        pAddr.balance = pAddr.balance.add(balance);
        addrs[accounts[accAddr].refAddr] = pAddr;

        return true;
    }

    function setLevel1(uint256 newLevel1,uint256 newlevelRate1) public onlyOwner {
        level1 = newLevel1;
        levelRate1 = newlevelRate1;
    }

    function setLevel2(uint256 newLevel2,uint256 newlevelRate2) public onlyOwner {
        level2 = newLevel2;
        levelRate2 = newlevelRate2;
    }

    function setLevel3(uint256 newLevel3,uint256 newlevelRate3) public onlyOwner {
        level3 = newLevel3;
        levelRate3 = newlevelRate3;
    }

    function setDayNums (uint256 newDayNums) public onlyOwner {
        dayNums = newDayNums;
    }
    function setRatePNC(uint256 newRatePNC) public onlyOwner {
        ratePNC = newRatePNC;
    }
    function setPncAddr (address newPNCAddr) public onlyOwner {
        pncAddr = newPNCAddr;
    }

    function setPair (address newPair) public onlyOwner {
        pair = IPancakePair(newPair);
    }

    function addSale(uint256 amount) public onlyOwner {
        sale.push(amount);
    }

    function setWidthAddr(address newWidthAddr) public onlyOwner {
        widthAddr = newWidthAddr;
    }

    function getAccountsAccStart(address addr) public view returns(ProxyAccount[] memory){

        if (addrs[addr].addr == address(0)) {
            ProxyAccount[] memory p;
            return p;
        }

        ProxyAccount[] memory  pas = new ProxyAccount[](20);
        uint inx = 0;
        for (uint256 i = addrs[addr].accs;i < addrs[addr].accs+200;i+=10) {
            ProxyAccount memory pa = accounts[accToAddr[i]];
            if (pa.account == 0) {
                pa.account = i;
            }
            pas[inx]=pa;
            inx++;
        }
        return pas;
    }
}
