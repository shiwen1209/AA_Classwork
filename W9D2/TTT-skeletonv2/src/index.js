const View = require("./ttt-view.js")
const Game = require("../ttt_node/game.js")

window.View = View;
window.Game = Game;


document.addEventListener("DOMContentLoaded", () => {
  const el = document.querySelector(".ttt")
  const newGame = new Game();
  const newView = new View(newGame, el);
  // newView.setupBoard();
});