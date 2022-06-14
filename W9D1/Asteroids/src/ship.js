const MovingObject = require("./moving_object.js");
const Util = require("./utils.js");
const Bullet = require("./bullet.js");


function Ship() {
  Ship.COLOR = "#ff0000";
  Ship.RADIUS = 15;
  MovingObject.call(this, {
    pos: [Math.random() * 635, Math.random() * 475],
    vel: [0,0],
    color: Ship.COLOR,
    radius: Ship.RADIUS 
  })
}

Util.inherits(Ship, MovingObject);

Ship.prototype.reloc = function(){
  this.pos = [Math.random() * 640, Math.random() * 640];
  this.vel = [0,0];
}

Ship.prototype.power = function (impulse){
    this.vel[1] = impulse[1]
    this.vel[0] = impulse[0]
}

Ship.prototype.fireBullet = function (){
  if (this.vel[0] !=0 || this.vel[1] !=0){
  let pos = [this.pos[0], this.pos[1]];
  let vel = [this.vel[0], this.vel[1]];
  let bullet = new Bullet(pos, vel);
   return bullet;
  } else {return false}
}

module.exports = Ship;
