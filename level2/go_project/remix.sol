pragma solidity ^0.8.26;

contract Remix {
  event ItemSet(uint256 key, uint256 value);

  string public version;
  mapping (uint256 => uint256) public items;

  constructor(string memory _version) {
    version = _version;
  }

  function setItem(uint256 key, uint256 value) external {
    items[key] = value;
    emit ItemSet(key, value);
  }
}