// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MemeCoin is ERC20, Ownable {
    mapping(address => bool) private _blacklist;
    event Blacklisted(address indexed account, bool value);

    constructor() ERC20("MemeCoin", "MEME") {
        _mint(msg.sender, 1000000 * 10 ** decimals()); // 1 Million tokens
    }

    function mint(address to, uint256 amount) external onlyOwner {
        require(!_blacklist[to], "Address is blacklisted");
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        require(!_blacklist[msg.sender], "Address is blacklisted");
        _burn(msg.sender, amount);
    }

    function addToBlacklist(address account) external onlyOwner {
        _blacklist[account] = true;
        emit Blacklisted(account, true);
    }

    function removeFromBlacklist(address account) external onlyOwner {
        _blacklist[account] = false;
        emit Blacklisted(account, false);
    }

    function isBlacklisted(address account) external view returns (bool) {
        return _blacklist[account];
    }
}
