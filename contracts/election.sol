pragma solidity ^0.5.16;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount; 
        string party;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;

    // allowed users
    mapping(address => bool) private allowed_voters;

    // Read/write candidates
    mapping(uint => Candidate) public candidates;
    // Store Candidates Count
    uint public candidatesCount;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    constructor () public {
        addCandidate("Mahesh", "Ravenclaw");
        addCandidate("Ram", "Gryffindor");
        addCandidate("Ajay", "Slytherin");
        addCandidate("Rajesh", "Hufflepuff");
        addCandidate("Nota", "-");
        addVoter( 0x8feE5e67c3524F6E7F7164C44FF25a916Ceb7164);
        addVoter( 0x684fc101F8f5eCc64E8d2d0F48b256b521c866cA);
        addVoter(0x39C48872B85FD855797b112964c56b2881d3254c);
        addVoter(0x33B4a20CA240D7B3198136Cf3D4Ab447235E53eE);
        addVoter(0x8cd25cC9f10B02b18522eCFEAAfE697b3A329A3c);
    }

    function addCandidate (string memory _name, string memory _party) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0, _party);
    }

    function addVoter(address add) private {
        allowed_voters[add] = true;
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);
        require(allowed_voters[msg.sender] == true);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}