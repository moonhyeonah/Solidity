// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

contract CrowdFunding {
	// 투자자 구조체
	struct Investor {
		address addr;	// 투자자의 어드레스
		uint amount;	// 투자액
	}
	
	address public owner;		// 컨트랙트 소유자
	uint public numInvestors;	// 투자자 수
	uint public deadline;		// 마감일
	string public status;		// 모금활동 상태
	bool public ended;			// 모금 종료여부
	uint public goalAmount;		// 목표액
	uint public totalAmount;	// 총 투자액

	mapping (uint => Investor) public investors;	// 투자자 관리를 위한 매핑
	
    event Funded(address investor, uint amount, uint totalAmount);

	modifier onlyOwner () {
		require(msg.sender == owner, "Only owner");
		_;
	}
	
	// 생성자
	constructor(uint _duration, uint _goalAmount) {
		owner = msg.sender;

		// 마감일 설정
		deadline = block.timestamp + _duration;

		goalAmount = _goalAmount * 1 ether;
		status = "Funding";
		ended = false;

		numInvestors = 0;
		totalAmount = 0;
	}
	
	// 투자 시에 호출되는 함수
	function fund() public payable {
		// 모금이 끝났다면 처리 중단
        require(msg.value > 0, "Must send ETH");
		require(!ended, "Funding has ended");
        require(block.timestamp < deadline, "Deadline passed");
		
		//investors[numInvestors].addr = msg.sender;
		//investors[numInvestors].amount = msg.value;
        investors[numInvestors] = Investor(msg.sender, msg.value);
		totalAmount += msg.value;
        
        numInvestors++;

        emit Funded(msg.sender, msg.value, totalAmount);
	}
	
	// 목표액 달성 여부 확인
	// 그리고 모금 성공/실패 여부에 따라 송금
	function checkGoalReached () public onlyOwner {		
		// 모금이 끝났다면 처리 중단
		require(!ended, "Funding has ended");
		
		// 마감이 지나지 않았다면 처리 중단
		require(block.timestamp >= deadline, "Funding period not yet over");
		
		if(totalAmount >= goalAmount) {	// 모금 성공인 경우
			status = "Campaign Succeeded";
			ended = true;
			// 컨트랙트 소유자에게 컨트랙트에 있는 모든 이더를 송금
            payable(owner).transfer(address(this).balance);			
		} else {	// 모금 실패인 경우
			uint i = 0;
			status = "Campaign Failed";
			ended = true;
			
			// 각 투자자에게 투자금을 돌려줌
			while(i < numInvestors) {
                payable(investors[i].addr).transfer(investors[i].amount);
				i++;
			}
		}
	}

    // 투자자 전체 조회
    function getInvestors() public view returns (address[] memory, uint[] memory) {
        address[] memory addrs = new address[](numInvestors);
        uint[] memory amounts = new uint[](numInvestors);
        
        for (uint i = 0; i < numInvestors; i++) {
            addrs[i] = investors[i].addr;
            amounts[i] = investors[i].amount;
        }
        return (addrs, amounts);
    }
}