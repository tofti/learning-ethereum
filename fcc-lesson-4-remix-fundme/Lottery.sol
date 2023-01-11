// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

contract Lottery {
    uint256 public totalEthInWei;
    uint256 public ethDepositedInWei;

    mapping (address => uint256) allocations;
    address[] depositors;

    constructor (uint256 _totalEthInWei) {
        require(_totalEthInWei > 0, "Must construct loterry with >0 wei");
        totalEthInWei = _totalEthInWei;
    }

    function deposit() public payable returns (uint256, uint256) {
        require(msg.value > 0, "Deposit value must be greater than zero");
        require(ethDepositedInWei + msg.value <= totalEthInWei, "Lottery would be oversubscribed.");

        if (allocations[msg.sender] == 0) {
            depositors.push(msg.sender);
        }

        allocations[msg.sender] += msg.value;    
        ethDepositedInWei += msg.value;   
        
        if (isFullyAllocated()) {
            payout();
        }
        
        return (msg.value, totalEthInWei);
    } 

    function isFullyAllocated() public view returns (bool) {
        return ethDepositedInWei == totalEthInWei;
    }

    event lotteryWin (
        address indexed winnerAddress,
        uint256 indexed winningsEthInWei
    );

    // example: totalEthInWei => 77
    // a -> 33
    // b -> 22
    // c -> 22
    // [a, b, c]
    
    // r = 1, winner -> a
    // r = 77, winner -> c
    // r = 33, winner -> a
    // r = 44. winner -> b
    function payout() private {
        uint256 r = randInt();
        uint256 sum;
        for (uint j = 0; j < depositors.length; j++) {
            sum += allocations[depositors[j]];
            if (sum >= r) {
                address payable winner = payable(depositors[j]);
                bool sent = winner.send(totalEthInWei);
                require(sent, "Failed to send Ether");
                emit lotteryWin(
                    winner,
                    totalEthInWei
                );
                return;
            }
        }
    }

    // chainlink https://vrf.chain.link/goerli/8489
    // [1, ..., totalEthInWei]
    function randInt() private pure returns (uint256) {
        return 33;
    }
}