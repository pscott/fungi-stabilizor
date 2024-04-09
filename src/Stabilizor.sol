// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "forge-std/console2.sol";

contract Stabilizor {
    IERC20 public token;

    constructor(IERC20 _tokenAddress) {
        token = _tokenAddress;
    }

    function stabilizeMultiple(uint256[] calldata amounts) public {
        address sender = msg.sender;

        uint256 fullBalance = token.balanceOf(sender);

        // First transfer the sender's full balance
        token.transferFrom(sender, address(this), fullBalance);

        // For each amount, stabilize the NFT
        for (uint256 i = 0; i < amounts.length; i++) {
            token.transfer(sender, amounts[i]);
            token.transferFrom(sender, address(this), amounts[i]);
            token.transfer(sender, amounts[i]);

            // If this underflows, this means the user did not have a high enough balance
            fullBalance -= amounts[i];
        }

        // Transfer back the remaining balance
        token.transfer(sender, fullBalance);
    }

    function stabilize(uint256 amount) public {
        address sender = msg.sender;

        token.transferFrom(sender, address(this), amount);
        token.transfer(sender, amount);
    }
}
