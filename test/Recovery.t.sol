// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Recovery.sol";

contract RecoveryTest is Test {

    Recovery recovery;
    RecoverFunds recoverFunds;

    function setUp() public {
        recovery = new Recovery();
        recoverFunds = new RecoverFunds(address(recovery));
        vm.deal(address(recoverFunds), 0.001 ether);
    }

    function testRecoveryFunds() public {
        uint256 nonce = vm.getNonce(address(recovery));
        console.log("Recovery contract nonce: ", nonce);

        recoverFunds.generateToken();
        recoverFunds.recover(nonce);
        assertEq(address(recoverFunds).balance, 0.001 ether);
    }
}