// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import {console} from 'forge-std/Test.sol';
contract Counter {
    address public owner;
    uint256 public number;

    constructor () {
        owner = msg.sender;
    }
     
    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
