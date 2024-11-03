// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {Reentrance, Attacker} from "../src/Reentrance.sol";

// TODO
// 原理是递归调用fallback, 从而获取更多Ether
// 但使用Foundry和remix测试不通过

contract ReentranceTest is Test {

    Reentrance reentrance;
    Attacker attacker;

    function setUp() public {
        reentrance = new Reentrance();
        attacker = new Attacker(address(reentrance));
        vm.deal(address(attacker), 1 ether);
        vm.deal(address(reentrance), 2 ether);
    }

    function testReentrance() public {
        console.log(address(this).balance);
        console.log(address(attacker).balance);
        attacker.attack();
    
        console.log(address(attacker).balance);
        assertEq(address(reentrance).balance, 0 ether); 
    }
}