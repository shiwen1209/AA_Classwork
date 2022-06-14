const moving_object = require("./moving_object")
const Asteroid = require("./asteroid")
const Ship = require("./ship")
const Bullet = require("./bullet.js");

function Game(){
  Game.DIM_X = 640;
  Game.DIM_Y = 480;
  Game.NUM_ASTEROIDS = 20;
  this.asteroidArr = this.add_asteroids();
  this.ship = new Ship();
  this.bullets = []
  this.allObjects = this.asteroidArr.concat([this.ship]).concat(this.bullets);
}

Game.prototype.add_asteroids = function(){
    let asteroidsArr = []
    while (asteroidsArr.length < Game.NUM_ASTEROIDS) {
    let a = new Asteroid ([Math.random()*Game.DIM_X,Math.random()*Game.DIM_Y]);
    a.id = asteroidsArr.length
    asteroidsArr.push(a);
    }
    return asteroidsArr;
}

Game.prototype.add = function(obj) {
  if (obj.constructor === Bullet){
    this.bullets.push(obj);
  } else if (obj.constructor === Asteroid){
      this.asteroidArr.push(obj);
  }
}

Game.prototype.draw = function(ctx){
  ctx.clearRect(0,0,Game.DIM_X, Game.DIM_Y)
  this.allObjects = this.asteroidArr.concat([this.ship]).concat(this.bullets);
  this.allObjects.forEach(function (el) { el.draw(ctx)})

}

Game.prototype.move = function(){
  this.allObjects.forEach(function(el) {el.move()})
  let that = this;
  this.allObjects.forEach(function(el) {
    if(el.isWrappable){
    that.wrap(el.pos)
    } else if (that.isOutOfBounds(el.pos))
    { that.remove(el)}
  } )
}

Game.prototype.wrap = function(pos){
  if (pos[0] > Game.DIM_X) {pos[0] = pos[0] % Game.DIM_X}
  if (pos[1] > Game.DIM_Y) {pos[1] = pos[1] % Game.DIM_Y}
  if (pos[0] < 0) { pos[0] = (pos[0] + Game.DIM_X) }
  if (pos[1] < 0) { pos[1] = (pos[1] + Game.DIM_Y) }

}

Game.prototype.step = function (){
  this.move();
  this.checkCollisions();
}


Game.prototype.remove = function (obj){
if (obj.constructor === Asteroid){
  this.asteroidArr = this.asteroidArr.filter(function(item){return item !== obj;})
  } else if (obj.constructor === Bullet){
  this.bullets = this.bullets.filter(function(item){ return item !== obj; })
  }
}

Game.prototype.checkCollisions = function(){
    for(let i =0; i< this.asteroidArr.length; i++){
          
      if(this.asteroidArr[i].isCollidedWith(this.ship)){ 
                this.ship.reloc();
        }
    
      for(let j = 0; j < this.bullets.length; j++){
        if (this.asteroidArr[i].isCollidedWith(this.bullets[j])) {
          this.remove(this.bullets[j]);
          this.remove(this.asteroidArr[i]);
          break;
        }}
        }
    }

Game.prototype.isOutOfBounds = function(pos){
  if (pos[0] > Game.DIM_X || pos[0] < 0 || 
    pos[1] > Game.DIM_Y || pos[1] < 0){
      return true;
    }
  return false;
}



module.exports = Game;
