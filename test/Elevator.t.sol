// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {Elevator, ImplBuilding} from "../src/Elevator.sol";

contract ElevatorTest is Test {
    Elevator elevator;
    ImplBuilding implBuilding;
    function setUp() public {
        elevator = new Elevator();
        implBuilding = new ImplBuilding(address(elevator));
    }

    // 通过新建合约更改了Elevator的状态变量
    function testImplBuildingGoto() public {

        assertEq(elevator.top(), false);

        implBuilding.goToLayer(2);
        assertEq(elevator.top(), true);
        assertEq(elevator.floor(), 2);
    }
}