// SPDX-License-Identifier: MIT
pragma solidity 0.8.18; // solidity versions

contract SimpleStorage {
    uint256 deployerFavoriteNumber; // 0

    // uint256[] favoriteNumbers;
    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    Person[] public peoplesFavorites; // []

    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public virtual {
        deployerFavoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return deployerFavoriteNumber;
    }

    function addFavorite(string memory _name, uint256 _favoriteNumber) public {
        peoplesFavorites.push(Person(_favoriteNumber, _name));

        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}

contract SimpleStorage2 {}

contract SimpleStorage3 {}

contract SimpleStorage4 {}

