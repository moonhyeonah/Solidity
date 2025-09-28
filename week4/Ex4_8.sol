// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

contract Ex4_8 {
    uint a = 5;
    uint b = 5;
    uint c = 5;
    uint d = 5;
    uint e = 5;

    function assignment() public returns(uint, uint, uint, uint, uint) {
        a += 2; 	// a = a + 2
        b -= 2; 	// b = b - 2
        c *= 2; 	// c = c * 2
        d /= 5; 	// d = d / 5
        e %= 2; 	// e = e % 2    
        return(a, b, c, d, e);
    }
}
