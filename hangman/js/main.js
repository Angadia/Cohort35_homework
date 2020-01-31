$(document)
  .ready( () => {
    
    const mysteryWord = ["ROCK", "PAPER", "SCISSORS"][Math.floor(Math.random()*3)];
    
    function createMysteryWordTableEntries(mysteryWord) {
      returnHTML = '<tr>';
      for (let index = 0; index < mysteryWord.length; index++) {
        returnHTML += `<td>${mysteryWord[index]}</td>`;
      }
      returnHTML += '</tr>';
      return returnHTML;
    };

    $('table.mysteryWord').prepend($(createMysteryWordTableEntries(mysteryWord)));
    
    function checkTheGuess(jQeCT) {
      let notFound = true;
      for (let index = 0; index < mysteryWord.length; index++) {
        if (jQeCT.text() === mysteryWord[index]) {
          notFound = false;
          $(`table.mysteryWord td:nth-child(${index+1})`).css("color", "grey");
        }
      }
      if (notFound) {
        console.log('Not found ', jQeCT.text())
      }
    }
    $('table.alphabets td').on('click', e => {
      const jQeCT = $(e.currentTarget);
      if (!jQeCT.hasClass('selected')) {
        jQeCT.addClass('selected');
        checkTheGuess(jQeCT);
      }
    });
  });
