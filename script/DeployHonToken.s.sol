// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {HonToken} from "../src/HonToken.sol";

contract DeployHonToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1000 ether;

    function run() external returns (HonToken) {
        vm.startBroadcast();
        HonToken honToken = new HonToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return honToken;
    }
}
