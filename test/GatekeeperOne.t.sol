// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/GatekeeperOne.sol";
import "forge-std/Test.sol";

contract PrivacyTest is Test {
    GatekeeperOne gko;
    GatekeeperOneAttack gkoAttack;

    function setUp() public {
        gko = new GatekeeperOne();
        gkoAttack = new GatekeeperOneAttack(address(gko));

    }

    function test_enter() public {
        gkoAttack.attack();
        assertTrue(true);
    }
}
