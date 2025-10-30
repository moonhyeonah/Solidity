//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Receiver {
    
    string lastFunctionCalled; // 마지막으로 호출된 함수명을 저장

    fallback() external {
        lastFunctionCalled = "fallback()"; // 함수명 저장
    }
    function outPut() public payable {
        lastFunctionCalled = "outPut()"; // 함수명 저장
    }
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    function getLastFunctionCalled() public view returns (string memory) {
        return lastFunctionCalled; // 마지막으로 호출된 함수명을 반환
    }
}




