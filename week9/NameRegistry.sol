// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

contract NameRegistry {

	// 컨트랙트를 나타낼 구조체
	struct ContractInfo {	
		address contractOwner;        
		address contractAddress;        
		string description;    
	}

	// 등록된 컨트랙트 수
	uint public numContracts;

	// 컨트랙트를 저장할 매핑
	mapping(string => ContractInfo) public registeredContracts;
    
    string[] public contractNames;                    // 등록된 모든 이름을 저장

	// modifier: 등록된 소유자만 특정 기능 수행 가능
	modifier onlyOwner(string memory _name) {
	    require(registeredContracts[_name].contractOwner == msg.sender, "Not the owner");
		_;
	}

    // 이벤트
    event ContractRegistered(string indexed name, address indexed owner, address contractAddress);
    event ContractDeleted(string indexed name, address indexed owner);
    event ContractUpdated(string indexed name, address indexed owner, string updateType);

	// 생성자
	constructor() {
		numContracts = 0;
	}

	// 컨트랙트 등록    
	function registerContract(string memory _name, address _contractAddress, string memory _description) public {
		require(registeredContracts[_name].contractAddress == address(0), "Contract with this name already exists");
		registeredContracts[_name] = ContractInfo(msg.sender, _contractAddress, _description);
		numContracts++;

        // 배열에 이름 추가
        contractNames.push(_name);
        // 등록 이벤트 발생
        emit ContractRegistered(_name, msg.sender, _contractAddress);
	}	

	// 컨트랙트 삭제
	function unregisterContract(string memory _name) public onlyOwner(_name) {        
		require(registeredContracts[_name].contractAddress != address(0), "Contract not found");
		delete registeredContracts[_name];
		numContracts--;

        // 배열에서 해당 이름 제거
        for (uint i = 0; i < contractNames.length; i++) {
            if (keccak256(bytes(contractNames[i])) == keccak256(bytes(_name))) {
                contractNames[i] = contractNames[contractNames.length - 1]; // 마지막 요소 복사
                contractNames.pop(); // 마지막 요소 삭제
                break;
            }
        }

        // 삭제 이벤트 발생
        emit ContractDeleted(_name, msg.sender);
	}	
	
	// 컨트랙트 소유자 변경
	function changeOwner(string memory _name, address _newOwner) public onlyOwner(_name) {
		// address(0)로 변경하는 것을 방지
        require(_newOwner != address(0), "New owner cannot be zero address");
        registeredContracts[_name].contractOwner = _newOwner;
        // 업데이트 이벤트 발생
        emit ContractUpdated(_name, _newOwner, "OwnerChanged");
	}
	
	// 컨트랙트 소유자 정보 확인
	function getOwner(string memory _name) public view returns (address) {
		return registeredContracts[_name].contractOwner;
	}
    
	// 컨트랙트 어드레스 변경
	function setAddr(string memory _name, address _addr) public onlyOwner(_name) {
		registeredContracts[_name].contractAddress = _addr;
        // 업데이트 이벤트 발생
        emit ContractUpdated(_name, msg.sender, "AddressChanged");
	}
    
	// 컨트랙트 어드레스 확인
	function getAddr(string memory _name) public view returns (address) {
		return registeredContracts[_name].contractAddress;
	}
        
	// 컨트랙트 설명 변경
	function setDescription(string memory _name, string memory _description) public onlyOwner(_name) {
		registeredContracts[_name].description = _description;
        // 업데이트 이벤트 발생
        emit ContractUpdated(_name, msg.sender, "DescriptionChanged");
	}

	// 컨트랙트 설명 확인
	function getDescription(string memory _name) public view returns (string memory)  {
		return registeredContracts[_name].description;
	}

    function getAllContractNames() public view returns (string[] memory) {
        return contractNames;
    }
}