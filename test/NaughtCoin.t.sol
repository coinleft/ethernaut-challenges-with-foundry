// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/NaughtCoin.sol";

contract NaughtCoinTest is Test {

    NaughtCoin naughtCoin;
    AttackNaughtCoin attackNaughtCoin;
    address receiver;

    function setUp() public {
        
        receiver = address(this);
        attackNaughtCoin = new AttackNaughtCoin();

        vm.deal(address(attackNaughtCoin), 1 ether);
        vm.deal(address(receiver), 1 ether);
    }

    function testAttack() public {

        uint256 INITIAL_SUPPLY = 1000000 * (10 ** 18);
        assertEq(attackNaughtCoin.balanceOf(receiver), 0);

        attackNaughtCoin.attack(receiver);
        assertEq(attackNaughtCoin.balanceOf(receiver), INITIAL_SUPPLY);
    }

    
}

