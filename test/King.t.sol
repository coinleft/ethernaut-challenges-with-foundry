// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {King, ForeverKing} from "../src/King.sol";

contract KingTest is Test {

    King king;
    ForeverKing foreverKing;

    function setUp() public {

        king = new King{value: 1 ether}();
        foreverKing = new ForeverKing(address(king));

        vm.deal(address(king), 9 ether);
        vm.deal(address(foreverKing), 30 ether);
    }

    function testAttactKing() public {
        // Ensure the initial king is set correctly
        assertEq(king._king(), address(this));

        // Become the king with the MaliciousKing contract
        foreverKing.becomeKing{value: 2 ether}();
        assertEq(king._king(), address(foreverKing));

        // Someone trying to be the king.
        vm.startPrank(address(0x123));
        vm.deal(address(0x123), 10 ether);
        
        vm.expectRevert('Trying to replace king failed.');
        (bool success, ) = address(king).call{value: 3 ether}("");
        assertFalse(success);
    }

    receive() external payable {}
}
