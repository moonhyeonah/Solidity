// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Lottery {
    address public manager;
    address[] public players;

    event Enter(address player);
    event Winner(address winner);

    // 참여 단계
    enum Phase{Start, Done}
    Phase public currentPhase;

    constructor(){
        manager = msg.sender;
        currentPhase = Phase.Start;
    }

    modifier notManager(){
        require(msg.sender != manager, "Manager cannot enter");
        _;
    }
    modifier restricted(){
        require(msg.sender == manager, "you are not manager");
        _;
    }

    // 1 ether로 참여하는지, 이미 참여한 것은 아닌지 확인
    modifier beforeEnter(){
        require(msg.value == 1 ether, "value is not 1 ether");
        for(uint i=0;i<players.length;i++){
            require(players[i] != msg.sender, "you already entered");
        }
        _;
    }

    function getPlayers() public view returns (address[] memory){
        return players;
    }

    function enter() public payable notManager beforeEnter{
        require(currentPhase == Phase.Start, "not valid Phase");
        players.push(msg.sender);
        emit Enter(msg.sender);
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.number, block.timestamp, players.length)));
    }

    // 참여 단계 변경
    function changePhase()public restricted{
        if(currentPhase == Phase.Start)
            currentPhase = Phase.Done;
        else if(currentPhase == Phase.Done)
            currentPhase = Phase.Start;
    }

    function pickWinner() public restricted{
        require(currentPhase == Phase.Done, "not valid Phase");
        address winner = players[random() % players.length];
        payable(winner).transfer(players.length * 1 ether);
        emit Winner(winner);
        delete players;
    }
}
