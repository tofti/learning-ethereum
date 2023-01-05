// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

import "./FactBase.sol";
import "./FunkyFactBase.sol";

// free standing function has to be pure
function hashCompareWithLengthCheck(string memory a, string memory b) pure returns (bool) {
    if(bytes(a).length != bytes(b).length) {
        return false;
    } else {
        return keccak256(bytes(a)) == keccak256(bytes(b));
    }
}

contract FactBaseFactory {

    mapping (string => FactBase) public factBases;

    function createFactBase(string memory _name) public returns (address) {
        if (hashCompareWithLengthCheck(_name, "funky")) {
            FactBase ffb = new FunkyFactBase();
            factBases[_name] = ffb;
            return address(ffb);
        } 
        
        FactBase fb = new FactBase();
        factBases[_name] = fb;
        return address(fb);    
    }

    function storeFactInBase(string memory _name, string memory _factName, string memory _factValue) public {
        FactBase fb = factBases[_name];
        if (address(fb) != address(0)) {
            fb.addFact(_factName, _factValue);
        }
        
    }

    function retrieveFactFromBase(string memory _name, string memory _factName) public view returns (string memory) {
        FactBase fb = factBases[_name];
        if (address(fb) != address(0)) {
            return fb.retrieveFact(_factName);
        }

        return "unavailable";
    }

}