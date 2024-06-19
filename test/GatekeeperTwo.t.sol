// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/GatekeeperTwo.sol";

contract Gatekeeper2Test is Test {
    GatekeeperTwo gko2;
    Gatekeeper2Attack gkoAttack2;

    function setUp() public {
        gko2 = new GatekeeperTwo();
    }

    function test_Gatekeeper2Attack() public {
        gkoAttack2 = new Gatekeeper2Attack(address(gko2));
        assertEq(gko2.entrant(), msg.sender);
    }
}


