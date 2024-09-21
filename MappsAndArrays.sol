// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract LearningSol {
    
    mapping(address => uint256) public myMap;

    function setMyMap(address _addr, uint256 _i) public {
        myMap[_addr] = _i;
    }

    function getMyMap(address _addr) view public returns(uint256) {
        return myMap[_addr];
    }

    mapping(address => mapping (uint256 => bool)) public myNestedMap;

    function setMyNestedMap(address _addr, uint256 _i, bool _bool) public {
        myNestedMap[_addr][_i] = _bool;
    }

    function getMyNestedMap(address _addr,  uint256 _i) view public returns(bool) {
        return myNestedMap[_addr][_i];
    }


}