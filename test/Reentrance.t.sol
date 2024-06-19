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
        vm.deal(address(attacker), 5 ether);
        vm.deal(address(reentrance), 3 ether);
    }

    function testReentrance() public {

        // assertEq(address(reentrance).balance, 3 ether);
        // assertEq(address(attacker).balance, 5 ether);
        // attacker.attack();
    
        // console.log(address(attacker).balance);
        // assertEq(address(attacker).balance, 6 ether); 


        // assertEq(address(reentrance).balance, 2 ether);
        // console.log(address(reentrance).balance);
        // console.log(address(attacker).balance);

        //  assertEq(address(attacker).balance, 6 ether);
        // assertEq(reentrance.balanceOf(address(attacker)), 1 ether);
    }
}