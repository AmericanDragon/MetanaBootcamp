// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyNFT is ERC721, Ownable {
    using Counters for Counters.Counter;
    IERC20 public tokenAddress;
    // rate at which a token equals an NFT (100/1)
    uint256 public rate = 10*10 ** 18;

    Counters.Counter private _tokenIdCounter;

    constructor(address _tokenAddress) ERC721("MyNFT", "MFT") {
        tokenAddress = IERC20(_tokenAddress);
    }

    function safeMint(uint256 _amount) public {
        tokenAddress.transferFrom(msg.sender, address(this), rate*_amount);
        for (uint i=0; i<_amount; i++){
            uint256 tokenId = _tokenIdCounter.current();
            _tokenIdCounter.increment();
            _safeMint(msg.sender, tokenId);
        }

    }

    function withdrawToken() public onlyOwner {
        tokenAddress.transfer(msg.sender, tokenAddress.balanceOf(address(this)));
    }
}