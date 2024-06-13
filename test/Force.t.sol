// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {Force, ForceEther} from "../src/Force.sol";

contract ForceTest is Test {
    Force force;
    address owner;
    ForceEther forceEther;

    function setUp() public {
        force = new Force();
        forceEther = new ForceEther();
        vm.deal(address(forceEther), 1 ether);
    }

    function test_destroyAndSend() public {

        assertEq(address(forceEther).balance, 1 ether);
        assertEq(address(force).balance, 0);
        
        forceEther.destroyAndSend(payable(address(force)));
        
        assertEq(address(forceEther).balance, 0);
        assertEq(address(force).balance, 1 ether);
    } 
}

