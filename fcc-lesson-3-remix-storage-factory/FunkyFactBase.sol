// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

import "./FactBase.sol";

contract FunkyFactBase is FactBase {
    function retrieveFact(string memory _factName) public view override returns (string memory) {
        return string(bytes.concat(bytes(facts[_factName]) , bytes(" funky ")));
    }
}