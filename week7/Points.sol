//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Points {
    
    uint public total;
    event From(address from);

    function addPoints(uint _point) public {
        total += _point;
        emit From(msg.sender);
    }
}






