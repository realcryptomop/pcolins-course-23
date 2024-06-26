// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import{Script} from "forge-std/Script.sol";
import {FundMe}from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {

    function run() external returns (FundMe) {
        HelperConfig helperConfig = new HelperConfig();
        address ethUsdPricFeed = helperConfig.activeNetworkConfig();

        vm.startBroadcast();
        // Sepolia ETH / USD Address
        // https://docs.chain.link/data-feeds/price-feeds/addresses
        FundMe fundMe = new FundMe(ethUsdPricFeed);
        vm.stopBroadcast();

        return fundMe;
    }

}