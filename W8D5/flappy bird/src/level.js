export default class Level {
  constructor(dimensions) {
    this.dimensions = dimensions;
    let pipe1 = [800, 200];
    let pipe2 = [1020, 350];
    let pipe3 = [1240, 300];
    this.pipes = [pipe1, pipe2, pipe3]

  }

  drawBackground(ctx) {
    ctx.fillStyle = "skyblue";
    ctx.fillRect(0, 0, this.dimensions.width, this.dimensions.height);
  }
  ///
  animate(ctx)
  {
    this.drawBackground(ctx);
    this.movePipes(3);
    this.drawPipes(ctx);
  }

  movePipes(amt){
    this.pipes.forEach((p, i)=> {
      this.pipes[i][0] -= amt;
    })

    for(let i = 0; i<this.pipes.length; i++)
    {
      if (this.pipes[0][i] <= -40)
      {
        this.pipes.shift();
        let x = this.pipes[this.pipes.length -1][0] + 220;
        let y = this.getRandomY(200, 390);
        this.pipes.push([x, y]);
        break;
      }
    }

    
    
  }

  drawPipes(ctx){
    this.pipes.forEach((p)=>{
      ctx.fillStyle = "green";
      ctx.fillRect(p[0], 0, 40, p[1]); 

      ctx.fillStyle = "green";
      ctx.fillRect(p[0], p[1] + 150, 40, 640-p[1]-150); 
    })

  }

  getRandomY(min, max) {
  return Math.random() * (max - min) + min;
}

  collidesWith(birdbounds) {
    for(let i = 0; i < this.pipes.length; i++){
      if( (birdbounds[0][0] < this.pipes[i][0] + 40 && birdbounds[0][0] > this.pipes[i][0]) || (birdbounds[1][0] < this.pipes[i][0] + 40 && birdbounds[1][0] > this.pipes[i][0])){
        if(
          birdbounds[1][1] >= this.pipes[i][1] + 150 ||
          birdbounds[0][1] <= this.pipes[i][1]
        ){return true; }
    }
    return false;
  }
  }



}

