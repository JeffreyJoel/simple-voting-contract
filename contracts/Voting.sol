// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract VotingPoll {
    address public creator;
    string public question;
    string[] public options;
    mapping(address => bool) public hasVoted;

    event VoteCasted(address indexed voter, uint indexed optionIndex);

    modifier onlyCreator() {
        require(msg.sender == creator, "Only the creator can perform this action");
        _;
    }

    modifier hasNotVoted() {
        require(!hasVoted[msg.sender], "You have already voted in this poll");
        _;
    }

    constructor(string memory _question, string[] memory _options) {
        creator = msg.sender;
        question = _question;
        options = _options;
    }

    function vote(uint optionIndex) external hasNotVoted {
        require(optionIndex < options.length, "Invalid option index");

        hasVoted[msg.sender] = true;

        emit VoteCasted(msg.sender, optionIndex);
    }
}

contract PollFactory {
    address[] public polls;

    event PollCreated(address indexed pollAddress, address indexed creator);

    function createPoll(string memory question, string[] memory options) external {
        VotingPoll newPoll = new VotingPoll(question, options);
        polls.push(address(newPoll));

        emit PollCreated(address(newPoll), msg.sender);
    }

    function getPolls() external view returns (address[] memory) {
        return polls;
    }
}
