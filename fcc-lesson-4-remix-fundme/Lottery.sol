// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

contract Lottery {
    uint256 totalEthInWei;
    uint256 ethDepositedInWei;

    mapping (address => uint256) allocations;
    address[] depositors;

    constructor (uint256 _totalEthInWei) {
        totalEthInWei = _totalEthInWei;
    }

    function deposit() public payable returns (uint256, uint256) {
        require() msg.value 
        require(ethDepositedInWei + msg.value < totalEthInWei, "Lottery would be oversubscribed.");
        

        if (allocations[msg.sender] == 0) {
            depositors.push(msg.sender);
        }

        allocations[msg.sender] += msg.value;    
        ethDepositedInWei += msg.value;   
        
        if (isFullyAllocated()) {
            payout();
        }
        
        return (1,1);
    } 

    function isFullyAllocated() private returns (bool) {
        return ethDepositedInWei == totalEthInWei;
    }

    function payout() private {

    }

}