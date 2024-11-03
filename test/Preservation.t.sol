// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Preservation.sol";

contract PreservationTest is Test {

    Preservation preservation;
    PreservationExploit preservationExploit;
    LibraryContract libraryContract1;
    LibraryContract libraryContract2;
    address newOwner = makeAddr("0x12345");

    function setUp() public {
        libraryContract1 = new LibraryContract();
        libraryContract2 = new LibraryContract();
        preservation = new Preservation(address(libraryContract1), address(libraryContract2));
        preservationExploit = new PreservationExploit(preservation);
    }

    function testAttact() public {
        assertEq(preservation.owner(), address(this));
        preservationExploit.attack(newOwner);
        assertEq(preservation.owner(), newOwner);
    }
}
