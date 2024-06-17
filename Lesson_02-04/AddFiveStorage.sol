// SPDX-License-Identifier: MIT
pragma solidity 0.8.18; // solidity versions

import {SimpleStorage} from "./SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage {
    function store(uint256 _newNumber) public override {
        deployerFavoriteNumber = _newNumber + 5;
    }
}
