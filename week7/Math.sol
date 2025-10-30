//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Math {
    uint result = 0; 
    function add(uint256 _num1, uint256 _num2) public {
        result = _num1 + _num2;
    }
    function returnResult() public view returns(uint) {
        return result;
    }
}




