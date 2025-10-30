// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.6;

contract SimpleStorage {
    uint min = 0;
    uint max = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
     
    function under() public view returns( uint) {
        return min - 1;
    }

    function over() public view returns( uint) {
        return max + 1;
    }
}
