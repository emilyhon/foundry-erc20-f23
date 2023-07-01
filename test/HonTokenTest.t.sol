// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {HonToken} from "../src/HonToken.sol";
import {DeployHonToken} from "../script/DeployHonToken.s.sol";

contract HonTokenTest is Test {
    HonToken public honToken;
    DeployHonToken public deployer;

    address testerA = makeAddr("testerA");
    address testerB = makeAddr("testerB");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployHonToken();
        honToken = deployer.run();

        vm.prank(msg.sender);
        honToken.transfer(testerA, STARTING_BALANCE);
    }

    function testTesterBalance() public {
        assertEq(STARTING_BALANCE, honToken.balanceOf(testerA));
    }

    function testAllowancesWorks() public {
        uint256 initialAllowance = 1000;

        // Tester A approves tester B to spend tokens on their behalf
        vm.prank(testerA);
        honToken.approve(testerB, initialAllowance);

        uint256 transferAmount = 500;

        vm.prank(testerB);
        honToken.transferFrom(testerA, testerB, transferAmount);

        assertEq(honToken.balanceOf(testerB), transferAmount);
        assertEq(
            honToken.balanceOf(testerA),
            STARTING_BALANCE - transferAmount
        );
    }
}
