// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../src/Counter.sol";

contract CounterScript is Script {
    function setUp() public {}
    function run() public returns (Counter) {
        vm.startBroadcast();
        Counter c = new Counter();
        vm.stopBroadcast();
        return c;
    }
}
