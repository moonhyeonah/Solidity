// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Lottery {
    address public manager;
    address[] public players;

    modifier restricted() {
        require(msg.sender == manager, "Only the manager can call this function");
        _;
    }

    constructor() {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value == 1 ether, "Only 1 Ether is Allowed");
        require(checkDup() == false, "You can participate only once.");
        players.push(msg.sender);
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.number, block.timestamp, players.length)));
    }

    function pickWinner() public restricted {
        uint index = random() % players.length;
        address winner = players[index];
        delete players;
        payable(winner).transfer(address(this).balance);  // Transfer the contract's balance to the winner
    }

    function getPlayers() public view returns (address[] memory) {
        return players;
    }

    function checkDup() private view returns (bool) {
        for (uint i = 0; i < players.length; i++) {
            if (players[i] == msg.sender) {
                return true;
            }
        }
        return false;
    }
}




