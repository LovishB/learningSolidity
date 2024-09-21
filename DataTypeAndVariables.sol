// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract HelloWorld {
    string public constant greet = "Hello world";
    uint256 public count;
    address public immutable ownerAddress;
    uint256 public temp;

    constructor(address owner) {
        ownerAddress = owner;
    }

    function get() public view returns (uint256) {
        return temp;
    }

    function inc() public {
        count += 1;
    }

    function getSenderAddr() public view returns (address) {
        return msg.sender;
    }

    function greetings() public pure returns (string memory) {
        return greet;
    }

    function updateTemp(uint256 TEMP) public {
        temp = TEMP;
    }

    uint public i = 0;
    function forever() public {
        while(true) {
            i += 1;
        }
    }
}