// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {Privacy} from "../src/Privacy.sol";

contract PrivacyTest is Test {
    Privacy privacy;
    address owner;

    function setUp() public {
        bytes32[3] memory data = [
            bytes32(uint256(1)),
            bytes32(0x0000000000000000000000000000000000000000000000000000000000000002),
            bytes32(0x0000000000000000000000000000000000000000000000000000000000000003)
        ];

        privacy = new Privacy(data);
    }

    function test_unlock() public {
        bytes32 gotdata = vm.load(address(privacy), bytes32(uint256(5)));
        assertEq(bytes32(uint256(3)), gotdata);
        bytes16 key = bytes16(gotdata);

        privacy.unlock(key);
        assertFalse(privacy.locked());
    }
}