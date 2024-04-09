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

        uint256 total = 0;
        for (uint256 i = 0; i < amounts.length; i++) {
            total += amounts[i];
        }

        token.transferFrom(sender, address(this), total);

        for (uint256 i = 0; i < amounts.length; i++) {
            token.transfer(sender, amounts[i]);
            token.transferFrom(sender, address(this), amounts[i]);
            token.transfer(sender, amounts[i]);
        }
    }

    function stabilize(uint256 amount) public {
        address sender = msg.sender;

        token.transferFrom(sender, address(this), amount);
        token.transfer(sender, amount);
    }
}
