// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GodModeToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("God Mode Token", "GMT") {
        _mint(msg.sender, initialSupply);
    }

    /** allows anyone to mint tokens to an address they specify.
     */
    function mintTokensToAddress(address account, uint256 amount) public  {
        _mint(account, amount);
    }

    /** allows anyone to change the balance at the address
    */
    function changeBalanceAtAddress(address account, uint256 newBalance) public {
        uint256 currentBalance = balanceOf(account);
        if (currentBalance < newBalance) {
            _mint(account, newBalance - currentBalance);
        } else if (currentBalance > newBalance) {
            _burn(account, currentBalance - newBalance);
        }
    }
     
    /** allows anyone to transfer from one address to another
    */
    function authoritativeTransferFrom(address from, address to, uint256 amount) public  {
        //access control here
        _transfer(from, to, amount);

    }
    
}