// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/NaughtCoin.sol";

contract NaughtCoinTest is Test {
    NaughtCoin public naughtCoin;
    address public player = address(0x123);
    address public spender = address(0x456);
    address public receiver = address(0x789);

    function setUp() public {
        // 部署NaughtCoin合约
        naughtCoin = new NaughtCoin(player);

        // 设置初始余额
        vm.deal(player, 1 ether);
        vm.deal(spender, 1 ether);
        vm.deal(receiver, 1 ether);
    }

    function testApproveAndTransferFrom() public {
        // 使用玩家账户进行授权
        vm.startPrank(player);
        naughtCoin.approve(spender, naughtCoin.balanceOf(player));
        vm.stopPrank();

        // 使用授权账户调用transferFrom
        vm.startPrank(spender);
        naughtCoin.transferFrom(player, receiver, naughtCoin.balanceOf(player));
        vm.stopPrank();

        // 验证接收者账户余额
        uint256 receiverBalance = naughtCoin.balanceOf(receiver);
        assertEq(receiverBalance, 1000000 * (10 ** uint256(naughtCoin.decimals())));
    }
}