// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import { SimpleStorage } from "./SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage {

    function addFiveStorage() public {
        myFavoriteNumber = myFavoriteNumber + 5;
    }

    function store(uint256 _myFavoriteNumber) public override  {
        myFavoriteNumber = _myFavoriteNumber + 5;
    }
}
