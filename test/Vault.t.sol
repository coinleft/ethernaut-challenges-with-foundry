// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {Vault} from "../src/Vault.sol";

contract VaultTest is Test {
    Vault vault;
    address owner;
    bytes32 init_password_hash;

    function setUp() public {
        init_password_hash = keccak256(abi.encodePacked('coinleft'));
        vault = new Vault(init_password_hash);
    }

    function test_unlock() public {

        bytes32 password = vm.load(address(vault), bytes32(uint256(1)));
        vault.unlock(password);
        
        assertEq(init_password_hash, password);
        assertEq(vault.locked(), false);
    }
}