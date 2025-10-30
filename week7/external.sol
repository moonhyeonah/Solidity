// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

library MathLib {
    function add(uint a, uint b) external pure returns (uint) {
        return a + b;
    }
}

contract A {
    function f(uint x, uint y) public pure returns (uint) {
        return MathLib.add(x, y);
    }
}