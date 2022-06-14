// const Game = require("./game")

function MovingObject (object){
    this.object = object;
    this.pos = object.pos;
    this.vel = object.vel;
    this.radius = object.radius;
    this.color = object.color;
    this.isWrappable = true;
}


MovingObject.prototype.draw = function(ctx){
  
ctx.beginPath();
ctx.fillStyle = this.color;
ctx.arc(this.pos[0], this.pos[1], this.radius, 0, 2*Math.PI)
ctx.fill()

}

MovingObject.prototype.move = function (){
  this.pos[0] += this.vel[0]
  this.pos[1] += this.vel[1]
}


MovingObject.prototype.isCollidedWith = function (other) {
  let dist = Math.sqrt((this.pos[0] - other.pos[0]) ** 2 + (this.pos[1] - other.pos[1]) ** 2)
  if (dist < (this.radius + other.radius)) {return true;} 
  return false;
}

MovingObject.prototype.collidedWith = function (otherObject) {}



module.exports = MovingObject;
