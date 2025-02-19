pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    constructor(address initialOwner)
        ERC20("JETH", "MTK") // 合约名，代币符号
        Ownable(initialOwner)
    {
        _mint(msg.sender, 10000 * 10 ** decimals());
    }
}