// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import { SimpleStorage } from "./SimpleStorage.sol";

contract StorageFactory {

    SimpleStorage[] public listOfSimpleStorageContracts;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorageContractVar = new SimpleStorage();
        listOfSimpleStorageContracts.push(simpleStorageContractVar);
    }

    function sfStore(uint256 _index, uint256 _myFavoriteNumber) public {
        SimpleStorage simpleStorage = listOfSimpleStorageContracts[_index];
        simpleStorage.store(_myFavoriteNumber);
    }

    function sfGet(uint256 _index) public view returns (uint256){
         SimpleStorage simpleStorage = listOfSimpleStorageContracts[_index];
         return simpleStorage.retrieve();
    }
}
