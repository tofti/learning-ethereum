// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

contract LotteryFactory {
    function createLottery(uint256 _totalEthInWei) public returns (address) {
        Lottery l = new Lottery(_totalEthInWei);
        return address(l);        
    }
}