const MovingObject = require("./moving_object.js");
window.MovingObject = MovingObject;

const Asteroid = require("./asteroid.js");
window.Asteroid = Asteroid;

const Game = require("./game.js");
window.Game = Game;

const GameView = require("./game_view.js");
window.GameView = GameView;

window.addEventListener('DOMContentLoaded', (event) => {
    canvas = document.getElementById('game-canvas')
    canvas.getContext('2d');
  const game = new GameView(canvas.getContext("2d"));
    window.game = game;
    window.allobjects = game.allobjects
  window.ship = game.ship
    game.start();

});



