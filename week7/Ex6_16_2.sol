//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Ex6_16 {

    event Obtain(address from, uint amount, string message);

    receive() external payable {
        emit Obtain(msg.sender, msg.value, "receive");
    }

    fallback() external payable {
        emit Obtain(msg.sender, msg.value, "fallback");
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function sendEther() public payable {
        payable(address(this)).transfer(msg.value);
    }

}


