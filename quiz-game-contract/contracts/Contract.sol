// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract QuizGame {
    struct Quiz {
        string question;
        string answer;
    }

    Quiz[] public quizzes;
    address public quizMaster;
    bool public isGameActive;

    constructor() public {
        quizMaster = msg.sender;
        isGameActive = false;
    }

    function setQuestionAndAnswer(string memory _question, string memory _answer) public {
        require(msg.sender == quizMaster, "Only the quiz master can set the question and answer");
        quizzes.push(Quiz({question: _question, answer: _answer}));
        isGameActive = true;
    }

    function guessAnswer(uint quizIndex, string memory _answer) public view returns (string memory) {
        require(isGameActive, "Game is not active");
        require(quizIndex < quizzes.length, "Quiz does not exist");
        if (keccak256(abi.encodePacked(_answer)) == keccak256(abi.encodePacked(quizzes[quizIndex].answer))) {
            return "Congratulations! You have won the game.";
        } else {
            return "Sorry, your answer is incorrect.";
        }
    }
    function getQuizzes() public view returns (Quiz[] memory) {
        return quizzes;
    }
}