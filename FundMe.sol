// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

//importing the Aggregator Contract Interface (ABI)
//@chainlink/contracts is npm package
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    //This tells solidity to attach type uint256 to library
    using PriceConverter for uint256;

    AggregatorV3Interface internal dataFeed;
    address public immutable owner; //imatable(set at deployment time) and constant(set at compile time) do not get store in storage
    /*
     Created a object with Interface(ABI) and address
     */
    constructor() {
        dataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        owner = msg.sender;
    }

    uint256 public constant MINIMUM_USD = 5 * 1e18; //5 USD with 18 decimals

    //we need array + map approach as maps can't iterate in solidity
    address[] public funders;
    mapping(address => uint256) public addressFundedMap;

    //User can send Eth(>5USD) to contract
    function fund() public payable {
        //checking the value > 5 USD else revert
        require(PriceConverter.getConversionRate(dataFeed, msg.value) >= MINIMUM_USD, "You need to spend more ETH!");
        funders.push(msg.sender);
        addressFundedMap[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner {
        //looping on funders array
        for(uint256 i = 0; i<funders.length; i++) {
            address funder = funders[i];
            //reset funder on map
            addressFundedMap[funder] = 0;
        }
        //reseting funders array to a new array
        funders = new address[](0);

        //three different ways to send fund from contract

        //wrap address as payable object
        address senderAddress = msg.sender;

        //1 transfer - it returns error if failed, max 2300 gas
        payable(senderAddress).transfer(address(this).balance);

        //2 send - it return bool if failed, max 2300 gas
        bool isSuccess = payable(senderAddress).send(address(this).balance);
        require(isSuccess, "Send Failed");

        //3 call - low level call to function with send value, no capped gas
        (   bool callSuccess, 
            /* bytes dataReturned */
        ) = payable(senderAddress).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");

    }

    //Owner check Modifier
    modifier onlyOwner() {
        // require(msg.sender == owner, "Not Owner of Contract");
        // _;
        //more gas effecient
        if(msg.sender != owner) { revert NotOwner(); }
        _;
    }

    //What happens if someone send this contract money without calling fund function?
    //use recieve and fallback override functions and call fund() expeceitly
    receive() external payable { 
        fund();
    }  

    fallback() external payable {
        fund();
    }  

    // Ether is sent to contract
    //      is msg.data empty?
    //          /   \
    //         yes  no
    //         /     \
    //    receive()?  fallback()
    //     /   \
    //   yes   no
    //  /        \
    //receive()  fallback()

}

//Errors are more gas effecient than require
error NotOwner();
