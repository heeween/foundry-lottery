//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

error Raffle_NotEnoughETH();
contract Raffle {
    uint256 private immutable i_entranceFee;
    address payable[] private s_players;
    uint256 private i_interval;
    uint256 private s_lastTimeStamp;

    /**Event */
    event EnteredRaffle(address player);

    constructor(uint256 entranceFee, uint256 interval) {
        i_entranceFee = entranceFee;
        i_interval = interval;
    }

    function enterRaffle() public payable {
        if (msg.value < i_entranceFee) {
            revert Raffle_NotEnoughETH();
        }
        s_players.push(msg.sender);
        // 1. Makes migration easier
        // 2. Makes front end 'indexing' easier
        emit EnteredRaffle(msg.sender);
    }

    function pickWinner() public {
        // 1 Get a random number 2 Use the random to picker a player 3. Be automatically called
        if (block.timestamp - s_lastTimeStamp > i_interval) {
            revert();
        }
        // 1 Request the RNG 2 Get the random
        // 3. Use the random to pick a player

        s_lastTimeStamp = block.timestamp;
        requestId = COORDINATOR.requestRandomNumber(0, s_players.length - 1);
    }

    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
