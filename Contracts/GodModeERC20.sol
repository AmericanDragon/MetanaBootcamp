// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SanctionToken is ERC20 {
//create an owner of the contract
    address public owner;

    //makes the contract deployer the central authority
    constructor(uint256 initialSupply) ERC20("Sanction Token", "SAT") {
        _mint(msg.sender, initialSupply);
        owner = msg.sender;
    }

    // allows anyone to mint tokens to an address they specify.
    function mintTokensToAddress(address account, uint256 amount) public  {
        require(msg.sender == owner, "Only the owner can make an authoritative transfer");
        _mint(account, amount);
    }

    // allows anyone to change the balance at the address
    function changeBalanceAtAddress(address account, uint256 newBalance) public {
        require(msg.sender == owner, "Only the owner can make an authoritative transfer");
        uint256 currentBalance = balanceOf(account);
        if (currentBalance < newBalance) {
            _mint(account, newBalance - currentBalance);
        } else if (currentBalance > newBalance) {
            _burn(account, currentBalance - newBalance);
        }
    }
     
    // allows anyone to transfer from one address to another
    function authoritativeTransferFrom(address from, address to, uint256 amount) public  {
        require(msg.sender == owner, "Only the owner can make an authoritative transfer");
        _transfer(from, to, amount);

    }
    
}