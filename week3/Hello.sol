// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Counter{

    uint count;
    string test;
    bytes32 test2;
    constructor() {
        count = 0;
        test = "Hello World";
        test2 = "Hello2";
    }

    function getCount() public view returns(uint){
        return count;
    }

    function getbytes() public view returns(string memory){
        return test;
    }

    function getstring() public view returns(bytes32){
        return test2;
    }
    function incrementCount() public{
        count = count + 1;
    }
}