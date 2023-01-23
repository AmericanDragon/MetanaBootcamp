/// SPDX-License-Identifier: GPT-3.0
pragma solidity 0.8.7;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract OpenZeppelinNFT is ERC721, Ownable {

    uint256 public tokenSupply = 0;
    uint256 public constant MAX_SUPPLY = 10;
    uint256 public constant PRICE = 0 ether;

    address immutable deployer;

    constructor() ERC721("Fast Fighter Jets", "FFJ"){
        deployer = msg.sender;

    }

    function mint() external payable {
        require(tokenSupply < MAX_SUPPLY,"supply used up");
        require(msg.value == PRICE, "wrong price");
        _mint(msg.sender, tokenSupply);
        tokenSupply++;

    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmSpbhLRQsr1PZmcdCJXrwhesj4hsiEY3t9o79xpAoVV4V/";
    }

    function viewBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function withdraw() external {
        payable(deployer).transfer(address(this).balance);
    }
    //function renounceOwnership() public override  {
    //    require(false, "cannot renounce");
    //}
    //function transferOwnership(address newOwner) public override  {
    //    require(false, "cannot transfer");
    //}

}