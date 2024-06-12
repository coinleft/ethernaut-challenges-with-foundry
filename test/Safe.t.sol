
// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
import 'forge-std/Test.sol';
import {Safe} from '../src/Safe.sol';

contract SafeTest is Test {
    Safe safe;

    // Needed so the test contract itself can receive ether
    // when withdrawing
    receive() external payable {}

    function setUp() public {
        safe = new Safe();
    }

    function test_Withdraw() public {
        console.log('init fund: ', address(safe).balance);
        payable(address(safe)).transfer(1 ether);
        console.log('post transfer fund: ', address(safe).balance);

        uint256 preBalance = address(this).balance;
        console.log('before withdraw: ', preBalance);
        safe.withdraw();
        uint256 postBalance = address(this).balance;
        console.log('post withdraw: ', postBalance);
        assertEq(preBalance + 1 ether, postBalance);
    }
}