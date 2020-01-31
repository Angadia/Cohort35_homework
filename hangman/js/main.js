$(document)
  .ready( () => {
    
    const MAX_INCORRECT_TRIES = 7;
    
    const MYSTERY_WORD = ["ROCK", "PAPER", "SCISSORS"][Math.floor(Math.random()*3)];

    const applauseSound = new Audio('sounds/applause3.wav');
    const bombSound = new Audio('sounds/bomb_x.wav');
    
    let incorrectGuessCount = 0;
    let correctGuessCount = 0;
    
    function createMysteryWordTableEntries(MYSTERY_WORD) {
      returnHTML = '<tr>';
      for (let index = 0; index < MYSTERY_WORD.length; index++) {
        returnHTML += `<td>${MYSTERY_WORD[index]}</td>`;
      }
      returnHTML += '</tr>';
      return returnHTML;
    };

    $('table.mysteryWord').prepend($(createMysteryWordTableEntries(MYSTERY_WORD)));

    function updateTheImageForIncorrectGuess() {
      if (incorrectGuessCount < MAX_INCORRECT_TRIES) {
        $('img.hangmanImage').attr('src', `images/${incorrectGuessCount}.jpg`);
      }
      if (incorrectGuessCount+1 >= MAX_INCORRECT_TRIES) {
        bombSound.play();
        setTimeout(() => {
          $(alert("Better luck next time..."));
          location.reload();
        }, 3000);
      }
    };
    
    function checkTheGuess(guessChar) {
      let notFound = true;
      for (let index = 0; index < MYSTERY_WORD.length; index++) {
        if (guessChar === MYSTERY_WORD[index]) {
          notFound = false;
          correctGuessCount++;
          $(`table.mysteryWord td:nth-child(${index+1})`).css("color", "black");
        }
      }

      if (notFound) {
        incorrectGuessCount++;
        updateTheImageForIncorrectGuess();
      }
      
      if (correctGuessCount == MYSTERY_WORD.length) {
        applauseSound.play();
        setTimeout(() => {
          $(alert("Congratulations! You Won!"));
          location.reload();
        }, 3000);
      }
    };

    $('table.alphabets td').on('click', e => {
      const jQeCT = $(e.currentTarget);
      if (!jQeCT.hasClass('selected')) {
        jQeCT.addClass('selected');
        checkTheGuess(jQeCT.text());
      }
    });

    function updateTheAlphabet(guessChar) {
      const guessCharCode = guessChar.charCodeAt(0);
      const key = $(`table.alphabets tr:nth-child(${Math.floor((guessCharCode - 65 + 1) / 10)+1}) > td:nth-child(${(guessCharCode - 65 + 1) % 10})`);
      if (!key.hasClass('selected')) {
        key.addClass('selected');
        checkTheGuess(guessChar);
      }
    };

    $(document).on('keypress', e => {
      const keyPressed = e.key.toUpperCase();
      if (keyPressed >= 'A' && keyPressed <= 'Z') {
        updateTheAlphabet(keyPressed);
      }
    });
  });
