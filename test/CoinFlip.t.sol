// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {CoinFlip ,CoinFlipExploit} from "../src/CoinFlip.sol";

contract CoinFlipTest is Test {
    CoinFlip public coinFlipContract;
    CoinFlipExploit public coinFlipExploit;

    function setUp() public {
        coinFlipContract = new CoinFlip();
        coinFlipExploit = new CoinFlipExploit(address(coinFlipContract));
    }

    function testGuessTenTimes() public {
        // Call guessTenTimes to guess the outcome correctly 10 times
        coinFlipExploit.guessTenTimes();
        
        // Check if the consecutiveWins is 10
        assertEq(coinFlipContract.consecutiveWins(), 10);
    }
}