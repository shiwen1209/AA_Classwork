const Game = require("./game")
const Keymaster = require("../dist/keymaster");
const Bullet = require("./bullet")

function GameView(ctx){
  
  GameView.MOVES = {
      "w": [0, -1],
      "a": [-1, 0],
      "s": [0, 1],
      "d": [1, 0],
  };

    this.game = new Game();
    this.ctx = ctx;
}


GameView.prototype.start = function(){


let that = this;

setInterval(function () {
    that.game.step();
    that.game.draw(that.ctx);
    }, 50)

this.bindKeyHandlers()
  
}

GameView.prototype.bindKeyHandlers = function(){


    const ship = this.game.ship;
    Object.keys(GameView.MOVES).forEach(function (k) {
        const move = GameView.MOVES[k];
        key(k, function () { ship.power(move); });
    });
    key("space",  () => { 
        if (ship.fireBullet()){
        this.game.add(ship.fireBullet()) 
        }
    });


}

module.exports = GameView;
