// SPDX-License-Identifier: MIT

/**
 * @author 0xBerkicek
 * @dev Election contract
 */

pragma solidity ^0.8.7;

contract Election {

    struct Candidate {
        string name;
        string party;
        string imageUri;
    }

    modifier candidateExists(uint256 id) {
        require(id > 0, "Candidate doesn't exist");
        require(id <= candidateCount, "Candidate doesn't exist");
        _;
    }

        mapping(uint256 => Candidate) public candidates;
        mapping(uint256 => uint256) public votes;

        uint256 public totalVotes;
        uint256 public candidateCount;
        address owner;

    constructor() {
        owner = msg.sender;
    }

    function addCandidate(string calldata name, string calldata party, string calldata imageUri) public {
        require(msg.sender == owner, "Not the owner");
        candidateCount++;
        Candidate memory person = Candidate({ name: name, party: party, imageUri: imageUri });
        candidates[candidateCount] = person;
    }

    function vote(uint256 id) public candidateExists(id) {
        votes[id]++;
        totalVotes++;
    }

}