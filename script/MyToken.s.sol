// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyTokenScript is Script {

    function run() external {
        uint256 deployer = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployer);
        
        new MyToken("MyToken", "MT", 18, 1000000000000000000);
        vm.stopBroadcast();
    }
}