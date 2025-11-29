// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelRoom {
    enum Status {Vacant, Occupied}
    Status public currentStatus;

    event Occupy(address _occupant, uint _value);

    address payable owner;

    constructor() {
        owner = payable(msg.sender);
        currentStatus = Status.Vacant;
    }

    modifier onlyWhileVacant() {
        require(currentStatus == Status.Vacant, "Currently occupied.");
        _;
    }

    modifier costs(uint _amount) {
        require(msg.value >= _amount, "Not enough ether provided.");
        _;
    }

    function book() public payable onlyWhileVacant costs(10 ether) {
        currentStatus = Status.Occupied;
        owner.transfer(msg.value);  
        emit Occupy(msg.sender, msg.value);
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Only the owner can do.");
        _;
    }

    function reset() public onlyOwner {
        currentStatus = Status.Vacant;
    }    

}