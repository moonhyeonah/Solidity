// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Ballot {

    struct Voter {                     
        uint weight;
        bool voted;
        uint vote;
    }
    struct Proposal {                  
        uint voteCount;
    }

    address public chairperson;
    mapping(address => Voter) voters;  
    Proposal[] proposals;

    enum Phase {Init, Regs, Vote, Done}  
    Phase public currentPhase = Phase.Init;
    
    //modifiers
 
    modifier onlyChair() {
        require(msg.sender == chairperson, "Not a Chairperson");
        _;
    }
     
    modifier validVoter() {
        require(voters[msg.sender].weight > 0, "Not a Registered Voter");
        _;
    }

    modifier validPhase(Phase reqPhase) { 
        require(currentPhase == reqPhase, "phaseError"); 
        _; 
    }

    constructor (uint numProposals) {
        chairperson = msg.sender;
        
        for (uint8 prop = 0; prop < numProposals; prop ++)
            proposals.push(Proposal(0));
        
    }
    
    function advancePhase() onlyChair public {
        if (currentPhase == Phase.Init) {
            currentPhase = Phase.Regs;
        } else if (currentPhase == Phase.Regs) {
            currentPhase = Phase.Vote;
        } else if (currentPhase == Phase.Vote) {
            currentPhase = Phase.Done;
        } else {
            currentPhase = Phase.Init;
        }
    }
    // function advancePhase() onlyChair public {
    //     if (currentPhase == Phase.Done) {
    //         currentPhase = Phase.Init;
    //     } else {         
    //         currentPhase = Phase(uint(currentPhase) + 1);
    //     }      
    // }
     
    function register(address voter) public validPhase(Phase.Regs) onlyChair {
        //if (currentPhase != Phase.Regs) {revert();} 
        // require(currentPhase == Phase.Regs, "It must be the Regs Phase");
        
        if (voter == chairperson)
            voters[chairperson].weight = 2; // weight 2 for testing purposes
        else 
            voters[voter].weight = 1;
        voters[voter].voted = false;
    }
   
    function vote(uint toProposal) public  validPhase(Phase.Vote) validVoter {
        // require(currentPhase == Phase.Vote, "It must be the Vote Phase");

        require (!voters[msg.sender].voted); 
        require (toProposal < proposals.length); 
        
        voters[msg.sender].voted = true;
        voters[msg.sender].vote = toProposal;   
        proposals[toProposal].voteCount += voters[msg.sender].weight;
    }

    function reqWinner() public view validPhase(Phase.Done) returns (uint winningProposal) {
        // require(currentPhase == Phase.Done, "It must be the Done Phase");
       
        uint winningVoteCount = 0;
        for (uint prop = 0; prop < proposals.length; prop++) 
            if (proposals[prop].voteCount > winningVoteCount) {
                winningVoteCount = proposals[prop].voteCount;
                winningProposal = prop;
            }
    }
}