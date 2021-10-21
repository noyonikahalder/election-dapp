pragma solidity ^0.5.0;

contract Election{
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }
    //store the voters
    mapping(address => bool) public voters;
    mapping(uint =>Candidate) public candidates;
    uint public candidatesCount;

    event electionUpdates (uint id, string name, uint voteCount);
    event votedEvent (
        uint indexed _candidateId
    );

    constructor() public{
        addCandidates("candidate 1");
        addCandidates("candidate 2");
    }

    function addCandidates(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }
    function vote(uint _candidateId) public {
        //check the voter hasnt voted before
        require(!voters[msg.sender]);
        //only vote for valid candidate
        require(_candidateId >0 && _candidateId<= candidatesCount);
        //record the voter has voted
        voters[msg.sender] = true;
        //update votecount
        candidates[_candidateId].voteCount++;
        emit electionUpdates( _candidateId, candidates[_candidateId].name, candidates[_candidateId].voteCount);
        emit votedEvent(_candidateId);
        
        }
}