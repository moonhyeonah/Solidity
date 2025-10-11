// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract ContinueExample {
   
    function sumOnlyEvenNumbers() public pure returns(uint) {
        uint sumEven = 0; // 합계를 초기화

        for (uint i = 1; i <= 10; i++) {
            // 홀수는 건너뛰고 continue로 다음 반복으로 넘어감
            if (i % 2 != 0) {
                continue;
            }
            // 짝수만 합계에 더함
            sumEven += i;
        }
        return sumEven;
    }
}
