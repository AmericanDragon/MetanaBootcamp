// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract SanctionToken is ERC20 {
    mapping(address => bool) isBlacklisted;
    address public centralAuthority;

    constructor(uint256 initialSupply) ERC20("Sanction Token", "SAT") {
        _mint(msg.sender, initialSupply);
        centralAuthority = msg.sender;
    }

    function blacklist(address target) public {
        require(msg.sender == centralAuthority, "Only the central authority can blacklist addresses.");
        isBlacklisted[target] = true;
    }

    function unblacklist(address target) public {
        require(msg.sender == centralAuthority, "Only the central authority can unblacklist addresses.");
        isBlacklisted[target] = false;
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal override {
            require(!isBlacklisted[from], "Sender address is blacklisted.");
            require(!isBlacklisted[to], "Recipient address is blacklisted.");
    }


}