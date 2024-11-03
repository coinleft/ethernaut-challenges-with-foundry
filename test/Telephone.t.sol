// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {Telephone} from "../src/Telephone.sol";

contract FalloutTest is Test {
    Telephone tp;
    function setUp() public {
        tp = new Telephone();
    }

    function testReentrance() public {
        assertEq(address(this), tp.owner());
        tp.changeOwner(msg.sender);
        assertEq(msg.sender, tp.owner());
    }
}
