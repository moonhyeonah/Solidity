//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Points {    						// 기존 스마트 컨트랙트
    uint public total;
    function addPoints(uint _point) public {
        total += _point;
    }
}
contract Points2 {    						// 로직 변경하여 배포 
    uint public total;
    function addPoints(uint _point) public {
        total += _point*2;
    }
}
contract UserInfo {
    uint public total;

    function pointsUpWithDelegateCall(address _address, uint _point) public {
        (bool success, ) = _address.delegatecall(
            abi.encodeWithSignature("addPoints(uint256)",_point)            
            );
        require(success, "Failed");
    }
}







