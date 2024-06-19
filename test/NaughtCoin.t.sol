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
    

    // function testAllowance() public {
    //     // attackNaughtCoin.attack();
    //     // assertEq(address(attackNaughtCoin), address());

    //     // Approve this contract to spend player's tokens
    //     naughtCoin.approve(address(this), naughtCoin.balanceOf(naughtCoin.player()));

    //     // Transfer tokens from player to a new address
    //     naughtCoin.transferFrom(address(this), address(attackNaughtCoin), naughtCoin.balanceOf(address(this)));

    //     // naughtCoin.approve(address(attackNaughtCoin), naughtCoin.INITIAL_SUPPLY());

    //     // console.log(naughtCoin.allowance(naughtCoin.player(), address(attackNaughtCoin)));
    //     // naughtCoin.transferFrom(naughtCoin.player(), address(attackNaughtCoin), naughtCoin.INITIAL_SUPPLY());

    //     assertEq(naughtCoin.balanceOf(naughtCoin.player()), 0);
    // }

    // function testAttack() public {
    //     uint256 supply = naughtCoin.INITIAL_SUPPLY();
    //     // console.log(supply);
    //     // assertEq(naughtCoin.balanceOf(address(this)), supply);

    //     // console.log(naughtCoin.balanceOf(naughtCoin.player()));

    //     console.log(address(this), address(attackNaughtCoin));
    //     console.log(naughtCoin.player());

    //     vm.startPrank(address(this));
    //     attackNaughtCoin.attack();
    //     vm.stopPrank();

    //     uint allowce = naughtCoin.allowance(address(this), address(attackNaughtCoin));
    //     console.log(allowce);
    //     assertEq(naughtCoin.balanceOf(address(this)), 0);
    //     assertEq(naughtCoin.balanceOf(address(attackNaughtCoin)), supply);


    // }

    function testAttack() public {

        uint256 INITIAL_SUPPLY = 1000000 * (10 ** 18);
        assertEq(attackNaughtCoin.balanceOf(receiver), 0);

        attackNaughtCoin.attack(receiver);
        assertEq(attackNaughtCoin.balanceOf(receiver), INITIAL_SUPPLY);
    }

    
}

