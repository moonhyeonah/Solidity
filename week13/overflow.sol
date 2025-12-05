pragma solidity 0.4.18;

contract OverflowUnderFlow {
    uint public min = 0;
    uint public max = 2**256-1;
    
    function underflow() public {
        min -= 1;
    }

    function overflow() public {
        max += 1;
    }
}
