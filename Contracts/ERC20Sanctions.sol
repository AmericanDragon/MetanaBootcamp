// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract SanctionToken is ERC20 {
    //define a mapping of all ETH addresses and set to false
    mapping(address => bool) isBlacklisted;
    //create a global variable for the ETH address that can blacklist other addresses
    address public centralAuthority;
//makes the contract deployer the central authority
    constructor(uint256 initialSupply) ERC20("Sanction Token", "SAT") {
        _mint(msg.sender, initialSupply);
        centralAuthority = msg.sender;
    }
//central authority can blacklist an address by calling blackist function
//can also use public only owner (need to declare owner)
    function blacklist(address target) public  {
        require(msg.sender == centralAuthority, "Only the central authority can blacklist addresses.");
        isBlacklisted[target] = true;
    }
//central authority can also unblacklist an address by calling this function
    function unblacklist(address target) public {
        require(msg.sender == centralAuthority, "Only the central authority can unblacklist addresses.");
        //
        isBlacklisted[target] = false;
    }
//overwrite the _beforeTokenTransfer function so it checks that neither the from or to ETH adddresses are blacklisted before a transfer occurs
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal override {
            require(!isBlacklisted[from], "Sender address is blacklisted.");
            require(!isBlacklisted[to], "Recipient address is blacklisted.");
    }


}