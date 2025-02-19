pragma solidity ^0.8.26;

//不能直接部署抽象合约/接口
// 需要创建一个继承自该抽象合约的具体合约，并实现所有抽象函数的逻辑
abstract contract ERC20 {
    string public constant name = "";
    string public constant symbol = "";
    uint8 public constant decimals = 0;

    // 将所有的函数标记为 virtual
    function totalSupply() public view virtual returns (uint);
    function balanceOf(address tokenOwner) public view virtual returns (uint balance);
    function allowance(address tokenOwner, address spender) public view virtual returns (uint remaining);
    function transfer(address to, uint tokens) public virtual returns (bool success);
    function approve(address spender, uint tokens) public virtual returns (bool success);
    function transferFrom(address from, address to, uint tokens) public virtual returns (bool success);

    // 定义事件
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}
