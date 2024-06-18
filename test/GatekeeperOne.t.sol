// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/GatekeeperOne.sol";

contract GatekeeperOneTest is Test {
    GatekeeperOne gko;
    GatekeeperOneAttack gkoAttack;

    function setUp() public {
        gko = new GatekeeperOne();
        gkoAttack = new GatekeeperOneAttack(address(gko));

    }

    function test_enter() public {
        gkoAttack.attack();
        assertEq(gko.entrant(), msg.sender);
    }
}
