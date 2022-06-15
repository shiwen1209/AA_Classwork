const Game = require("../ttt_node/game.js")

class View {
  constructor(game, el) {
    this.el = el;
    this.game = game;
    this.setupBoard();
    this.handleClick = this.handleClick.bind(this);
    this.bindEvents();

    

  }

  setupBoard() {
    const ul = document.createElement("ul");
    const gameBoard = [];
    for(let i =0; i< 3; i++){
      for(let j=0; j <3; j++){
        gameBoard.push([i,j]);
      }
    }
    gameBoard.forEach((pos) => {
      const li = document.createElement("li");
      // li.append("a");
      li.dataset.position = `[${pos}]`;
      ul.append(li);
    })
    this.el.append(ul);
}
  
  bindEvents() {
    this.el.addEventListener('click', this.handleClick);
  }

  handleClick(e) {
    console.log(this.game)
    const li = e.target;
    this.makeMove(li);
  }
  
  makeMove(square) {
    let p = JSON.parse(square.dataset.position);
    if(!this.game.board.isEmptyPos(p)){
      alert("not an empty square!"); 
      return;
    }

    if (this.game.isOver()) {
      alert("Game is over!");
      return;
    }
    square.style.backgroundColor = 'white';
    square.append(this.game.currentPlayer);
    this.game.playMove(p)

    let x = document.getElementsByTagName("BODY")[0];

    if(this.game.isOver()){
      const p = document.createElement("p");
      p.append(`Congrats ${this.game.winner()}!`);
      p.style.fontSize = '50px';
      x.append(p);

      let arr = Array.from(document.querySelectorAll('li'))
      for (let i = 0; i < arr.length; i++) {
        const el = arr[i];
        if (el.innerHTML === `${this.game.winner()}`) {
          el.style.backgroundColor = 'green';
          el.style.color = 'white';
        } else {
          el.style.backgroundColor = 'white';
          el.style.color = 'red';
        }
      }
    }



  }

}



module.exports = View;
