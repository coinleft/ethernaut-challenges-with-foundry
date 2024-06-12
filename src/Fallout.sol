// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/Math.sol"; // modified

contract Fallout {
    // Instead of Math.sol, you should import SafeMath.sol if you are working with Solidity versions prior to 0.8. 
    // Since Solidity 0.8 has built-in overflow checks, SafeMath is no longer necessary, but for compatibility and explicitness,
    // you might still want to use it.

    using Math for uint256; // modified

    mapping(address => uint256) allocations;
    address payable public owner;

    /* constructor */
    function Fal1out() public payable {
        owner = payable(msg.sender);  // modified
        allocations[owner] = msg.value;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }

    function allocate() public payable {
        allocations[msg.sender] = msg.value; // modified
    }

    function sendAllocation(address payable allocator) public {
        require(allocations[allocator] > 0);
        allocator.transfer(allocations[allocator]);
    }

    function collectAllocations() public onlyOwner {
        payable(msg.sender).transfer(address(this).balance); // modified
    }

    function allocatorBalance(address allocator) public view returns (uint256) {
        return allocations[allocator];
    }
}