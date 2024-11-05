// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// import "forge-std/Test.sol";
// import "../src/AlienCodex.sol";

// contract AlienCodexTest is Test {

//     AlienCodex alienCodex;
//     AlienCodexExploit alienCodexExploit;

//     function setUp() public {
//         alienCodex = new AlienCodex();
//         alienCodexExploit = new AlienCodexExploit(address(alienCodex));
//     }

//     function testExploit() public {
//         assertEq(alienCodex.owner(), address(this));
//         // alienCodexExploit.exploit();
//         // assertEq(address(recoverFunds).balance, 0.001 ether);
//     }
// }