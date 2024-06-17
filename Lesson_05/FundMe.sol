// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "The minimum funding amount is 5 USD in ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }
 
    function withdraw() public onlyOwner{
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);
        
        // transfer
        // send
        // call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Withdrawal failed making the call() to send the balance.");
    }

    function getPrice() public view returns (uint256){
        return PriceConverter.getPrice();
    }

    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Only owners can call this function.");
        if(msg.sender != i_owner) { revert NotOwner(); }
        _;
    }

    receive() external payable { 
        fund();
    }

    fallback() external payable { 
        fund();
    }
}
