const MovingObject = require("./moving_object.js");
const Util = require("./utils.js");

function Bullet(pos, vel) {
  Bullet.COLOR = "#505050";
  Bullet.RADIUS = 2;
  MovingObject.call(this, {
      pos: pos, 
      vel: [vel[0]*10, vel[1]*10],
      color: Bullet.COLOR,
      radius: Bullet.RADIUS
    })
  this.isWrappable = false;
}

Util.inherits(Bullet, MovingObject);

module.exports = Bullet;
