//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Caller {

    function expectFallback(address _address) public  {
        (bool success, ) = _address.call(
            abi.encodeWithSignature("outPut2()")            // 존재하지 않는 함수 호출
            );
        require(success, "Failed");
    }




    function outPutWithEther(address _address) public payable {
        (bool success, ) = _address.call{value:msg.value}(
            abi.encodeWithSignature("outPut()")            
            );
        require(success, "Failed");
    }

}





