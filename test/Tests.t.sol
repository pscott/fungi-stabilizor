// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import {Test, console} from "forge-std/Test.sol";
import {Stabilizor} from "../src/Stabilizor.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20FixedSupply is ERC20 {
    constructor(uint256 initialSupply) public ERC20("Test token", "TST") {
        _mint(msg.sender, initialSupply);
    }
}

uint256 constant INITIAL_SUPPLY = 1000;

contract StabilizorTest is Test {
    Stabilizor stabilizor;
    IERC20 token;

    function setUp() public {
        // Deploy the contract
        ERC20FixedSupply addr = new ERC20FixedSupply(INITIAL_SUPPLY);
        token = IERC20(addr);
        stabilizor = new Stabilizor(token);
    }

    function testStabilize() public {
        uint256 amount = 100;
        token.approve(address(stabilizor), INITIAL_SUPPLY * 2);
        stabilizor.stabilize(amount);
        assertEq(token.balanceOf(address(this)), INITIAL_SUPPLY);
    }

    function testStabilizeMultiple() public {
        uint256[] memory amounts = new uint256[](3);
        amounts[0] = 25;
        amounts[1] = 70;
        amounts[2] = 5;

        token.approve(address(stabilizor), INITIAL_SUPPLY * 2);
        stabilizor.stabilizeMultiple(amounts);
        assertEq(token.balanceOf(address(this)), INITIAL_SUPPLY);
    }
}
