//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract UserInfo {

    uint public total;
    function pointUpWithCall(address _address, uint _point) public {
        (bool success, ) = _address.call(
            abi.encodeWithSignature("addPoints(uint256)",_point)            
            );
        require(success, "Failed");
    }

    function pointUpWithDelegateCall(address _address, uint _point) public {
        (bool success, ) = _address.delegatecall(
            abi.encodeWithSignature("addPoints(uint256)",_point)            
            );
        require(success, "Failed");
    }
}







