const CONSTANTS = {
    GRAVITY:  0.5,
    FLAP_SPEED:  -8,
    TERMINAL_VEL:  12,
    BIRD_WIDTH:  40,
    BIRD_HEIGHT:  30
  };

export default class Bird{
    constructor(dimensions){
        this.velocity = 0;
        this.dimensions = dimensions;
        this.x_pos = dimensions.width / 3;
        this.y_pos = dimensions.height / 2;
    }

    //this.dimensions.width, this.dimensions.height

    drawBird(ctx){

        ctx.fillStyle = "yellow";
        ctx.fillRect(this.x_pos, this.y_pos, CONSTANTS.BIRD_WIDTH, CONSTANTS.BIRD_HEIGHT); 

    }

    animate(ctx){
        this.move();
        this.drawBird(ctx);
    }

    move(){
        this.y_pos += this.velocity;
        this.velocity += CONSTANTS.GRAVITY;
    }

    flap(){
        this.velocity = CONSTANTS.FLAP_SPEED;
    }

    getBounds(){
        return [[this.x_pos, this.y_pos], [this.x_pos+CONSTANTS.BIRD_WIDTH, this.y_pos + CONSTANTS.BIRD_HEIGHT]];
    }

    outBounds(){
        return (this.y_pos < 0 || this.y_pos + 30 > 640)
    }



}
