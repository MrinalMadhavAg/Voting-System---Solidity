// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 < 0.9.0;

contract TwoCandidateVoting{

    address private admin;

    enum Status { OFF, ON }
    Status public votingStatus;

    uint candidate1Votes;
    uint candidate2Votes;

    mapping(address => bool) private hasVoted;

    constructor() {
        admin = msg.sender;
        votingStatus = Status.ON;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier votingOpen() {
        require(votingStatus == Status.ON, "Voting is currently OFF");
        _;
    }

    function toggleVoting(Status _status) public onlyAdmin {
        votingStatus = _status;
    }

    function vote(uint _candidateId) public votingOpen {
        require(!hasVoted[msg.sender], "You have already voted");
        require(_candidateId == 1 || _candidateId == 2, "Invalid candidate");

        if (_candidateId == 1) {
            candidate1Votes++;
        } else {
            candidate2Votes++;
        }

        hasVoted[msg.sender] = true;
    }

    function getVotes() public view returns (uint, uint) {
        return (candidate1Votes, candidate2Votes);
    }
}