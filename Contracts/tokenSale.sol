// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract SaleToken is ERC20 {
    //define a mapping of all ETH addresses and set to false
    mapping(address => bool) isBlacklisted;
    //create a global variable for the ETH address that can blacklist other addresses
    address public centralAuthority;
//makes the contract deployer the central authority
    constructor(uint256 initialSupply) ERC20("Sale Token", "SAL") {
        _mint(msg.sender, initialSupply*10**decimals());
        centralAuthority = msg.sender;
    }
//central authority can blacklist an address by calling blackist function
    function blacklist(address target) public {
        require(msg.sender == centralAuthority, "Only the central authority can blacklist addresses.");
        isBlacklisted[target] = true;
    }
//central authority can also unblacklist an address by calling this function
    function unblacklist(address target) public {
        require(msg.sender == centralAuthority, "Only the central authority can unblacklist addresses.");
        isBlacklisted[target] = false;
    }
//overwrite the _beforeTokenTransfer function so it checks that neither the from or to ETH adddresses are blacklisted before a transfer occurs
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal override {
            require(!isBlacklisted[from], "Sender address is blacklisted.");
            require(!isBlacklisted[to], "Recipient address is blacklisted.");
    }
//allow whoever pays into the contract to mint tokens in the ratio of 1ETH:1000 SAL tokens with a max supply of 1mill
    function mintTokens() public payable {
        require(totalSupply() <= 1000000*10**decimals(), "Token sale is closed, we have reached the maximum supply of 1 million tokens");
        uint256 tokensToMint = msg.value* 1000/(1 ether)*10**decimals();
        _mint(msg.sender, tokensToMint);
    }

//sell back function
    function sellBack(uint256 amount) external payable {
        require(amount > 0, "Cannot sell 0 or less tokens.");
        require(amount <= balanceOf(msg.sender)*10**decimals(), "Insufficient balance to sell.");
        // check if the contract has enough ether to pay the user
        require(address(this).balance/(1 ether) >= (amount/2000), "Contract does not have enough ether to pay user.");

        // approve the contract to withdraw the tokens from the user's balance
        approve(address(this), amount*10**decimals());
        // transfer the tokens from the user's balance to the contract

        transferFrom(msg.sender, address(this), amount*10**decimals());
        // calculate the ether to be paid to the user
        uint256 weitopay = (amount*0.5 ether/1000);
        // pay the user in ether
        address payable withdrawTo = payable(msg.sender);
        withdrawTo.transfer(weitopay);

}


//allow contract owner (central authority) to withdraw ETH from the contract write 

    function withdraw(address payable _receiver) external payable {
        require(msg.sender == centralAuthority, "Only the central authority can withdraw ether from the contract");
        require(address(this).balance > 0, "There is no ether to withdraw");
        //transfer ether?
        address payable withdrawAddress = payable(_receiver);
        withdrawAddress.transfer(address(this).balance);
    }
     

}
