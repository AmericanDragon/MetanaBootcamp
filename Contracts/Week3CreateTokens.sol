// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "GameItems.sol";

contract MintingAndForging {
    GameItemTokens token;

    constructor(GameItemTokens _address) {
        token = _address;
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
    {
        require(id == 0 || id == 1 || id == 2, "this token cannot be minted directly. Try forging it instead");
        token.mint(account, id, amount, data);
    }

    function forgeToken3(address account, uint256 amount, bytes memory data) public {
        // Check that the caller has enough token 0 and enough token 1
        require(token.balanceOf(account, 0) >= amount, "Not enough token 0");
        require(token.balanceOf(account, 1) >= amount, "Not enough token 1");

        // burn amounts of token 0 and 1
        token.burn(account, 0, amount);
        token.burn(account, 1, amount);

        // Mint  token 3 to the caller
        token.mint(account, 2, amount, data);

    }

    function forgeToken4(address account, uint256 amount, bytes memory data) public {
        // Check that the caller has enough token 1 and enough token 2
        require(token.balanceOf(account, 1) >= amount, "Not enough token 1");
        require(token.balanceOf(account, 2) >= amount, "Not enough token 2");

        // burn amounts of token 1 and 2
        token.burn(account, 1, amount);
        token.burn(account, 2, amount);

        // Mint  token 4 to the caller
        token.mint(account, 4, amount, data);

    }

    function forgeToken5(address account, uint256 amount, bytes memory data) public {
        // Check that the caller has enough token 0 and enough token 2
        require(token.balanceOf(account, 0) >= amount, "Not enough token 0");
        require(token.balanceOf(account, 2) >= amount, "Not enough token 2");

        // burn amounts of token 0 and 2
        token.burn(account, 0, amount);
        token.burn(account, 2, amount);

        // Mint  token 5 to the caller
        token.mint(account, 5, amount, data);

    }
    function forgeToken6(address account, uint256 amount, bytes memory data) public {
        // Check that the caller has enough token 0, token 1, and token 2
        require(token.balanceOf(account, 0) >= amount, "Not enough token 0");
        require(token.balanceOf(account, 1) >= amount, "Not enough token 1");
        require(token.balanceOf(account, 2) >= amount, "Not enough token 2");

        // burn amounts of token 0 and 2
        token.burn(account, 0, amount);
        token.burn(account, 1, amount);
        token.burn(account, 2, amount);

        // Mint  token 6 to the caller
        token.mint(account, 6, amount, data);

    }

    function tradeTokens()
}
