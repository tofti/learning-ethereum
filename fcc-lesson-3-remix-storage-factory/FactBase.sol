// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

contract FactBase {

    mapping (string => string) internal facts;

    function addFact(string memory _factName, string memory _factValue) public {
        facts[_factName] = _factValue;
    }

    function retrieveFact(string memory _factName) public view virtual returns (string memory) {
        return facts[_factName];
    }
}