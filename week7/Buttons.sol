//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Buttons {
    uint256 public data;

    function addButtons(address _address, uint _num1, uint _num2) public {
        (bool success, ) = _address.call(
            abi.encodeWithSignature("add(uint256,uint256)",_num1 ,_num2)            
            );
        require(success, "Failed");
    }
    function showResult(address _address) public returns(bytes memory) {
        (bool success, bytes memory result) = _address.call(
            abi.encodeWithSignature("returnResult()")
            );
        require(success, "Failed");
        data = abi.decode(result, (uint256));

        return result;
    }
}





