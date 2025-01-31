const controlsDiv = document.querySelector("#controls");
let computerScore = 0;
let humanScore = 0; 

function displayMessage(msg) {
    const resultConsole = document.querySelector("#results");
    const msgElement = document.createElement("p");
    msgElement.textContent = msg;
    resultConsole.appendChild(msgElement);
    console.log(msg);
    
}

function getComputerChoice() {
    // Generate random choice
    const numChoice = Math.ceil(Math.random() * 3);
    switch (numChoice) {
        case 1:
            return 'rock';
        case 2:
            return 'paper';
        case 3: 
            return 'scissors';
        default:
            return null;    // To test out numChoice
    }
}

// Test for getComputerChoice
// for (let i = 0; i < 10; i++) {
//     console.log(getComputerChoice());
// }

function updateScores(humanScore, computerScore) {
    const humanScoreElement = document.querySelector("#human-score");
    const botScoreElement = document.querySelector("#bot-score");

    humanScoreElement.textContent = humanScore;
    botScoreElement.textContent = computerScore;
}

function playRound(humanChoice) {
    // Check if game is still running
    if (humanScore < 5 && computerScore < 5) {
        displayMessage(`You chose: ${humanChoice}`);
        const computerChoice = getComputerChoice();
        // Check that both choices are given
        // console.assert(humanChoice && computerChoice, `Round: ${humanChoice ? "computer choice": "human choice"} is null`);

        // Compare choices based on game rules
        if (
            (humanChoice === 'rock' && computerChoice === 'scissors') || 
            (humanChoice === 'scissors' && computerChoice === 'paper') ||
            (humanChoice === 'paper' && computerChoice === 'rock')
        ) {
            // Human wins
            displayMessage(`You win: ${humanChoice} beats ${computerChoice}`);
            humanScore++;
        } else if (humanChoice === computerChoice) {
            // Tie
            displayMessage(`Tie: Both played ${humanChoice}`);
        } else {
            // Computer wins
            displayMessage(`You lose: ${computerChoice} beats ${humanChoice}`);
            computerScore++;
        }
        updateScores(humanScore, computerScore);
        return ((humanScore < 5 && computerScore < 5) ? 1 : 0);    // Can still start another round
    } else {
        return 0;    // Rounds ended
    }
}        

function listenHumanChoice(event) {
    switch (event.target.id) {
        case 'rock':
        case 'paper':
        case 'scissors':
            if (!playRound(event.target.id)) {
                displayMessage(`GAME WINNER: ${(humanScore > computerScore) ? "You" : "Computer"}!`);
                displayMessage(`REFRESH TO PLAY AGAIN!`);
                controlsDiv.removeEventListener('click', listenHumanChoice, false);
            }
            break;
    }
}

// Game starts
displayMessage(`WELCOME TO ROCK, PAPER, SCISSORS!`);

// Round is only when the player chooses their move
// click event delegation
controlsDiv.addEventListener('click', listenHumanChoice);