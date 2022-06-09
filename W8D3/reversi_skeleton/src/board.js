// DON'T TOUCH THIS CODE
if (typeof window === 'undefined'){
  var Piece = require("./piece");
}
// DON'T TOUCH THIS CODE

/**
 * Returns a 2D array (8 by 8) with two black pieces at [3, 4] and [4, 3]
 * and two white pieces at [3, 3] and [4, 4]
 */
function _makeGrid () {
  let grid = new Array(8).fill(0).map(() => new Array(8));
  grid[3][4] = new Piece("black");
  grid[4][3] = new Piece("black");
  grid[3][3] = new Piece("white");
  grid[4][4] = new Piece("white");
  return grid;
}

/**
 * Constructs a Board with a starting grid set up.
 */
function Board () {
  this.grid = _makeGrid();
}

Board.DIRS = [
  [ 0,  1], [ 1,  1], [ 1,  0],
  [ 1, -1], [ 0, -1], [-1, -1],
  [-1,  0], [-1,  1]
];

/**
 * Checks if a given position is on the Board.
 */
Board.prototype.isValidPos = function (pos) {
  if (pos[0] >= 0 && pos[0] < 8 && pos[1] >= 0 && pos[1] < 8){
    return true;
  }else{
    return false;
  }

};

/**
 * Returns the piece at a given [x, y] position,
 * throwing an Error if the position is invalid.
 */
Board.prototype.getPiece = function (pos) {
  if (this.isValidPos(pos)){
    if (this.grid[pos[0]][pos[1]]){
      return this.grid[pos[0]][pos[1]];
    } else {
      return undefined;
    }
  }else {
    throw new Error('Not valid pos!');
  }
};

/**
 * Checks if the piece at a given position
 * matches a given color.
 */
Board.prototype.isMine = function (pos, color) {
  let piece = this.grid[pos[0]][pos[1]];
  if(piece === undefined) return false;
  if(piece.color === color){
    return true;
  } else {
    return false;
  }

};

/**
 * Checks if a given position has a piece on it.
 */ 
Board.prototype.isOccupied = function (pos) {
  let piece = this.grid[pos[0]][pos[1]];
  if (piece === undefined) { return false } else {return true}

};

/**
 * Recursively follows a direction away from a starting position, adding each
 * piece of the opposite color until hitting another piece of the current color.
 * It then returns an array of all pieces between the starting position and
 * ending position.
 *
 * Returns an empty array if it reaches the end of the board before finding another piece
 * of the same color.
 *
 * Returns empty array if it hits an empty position.
 *
 * Returns empty array if no pieces of the opposite color are found.
 */
Board.prototype._positionsToFlip = function(pos, color, dir, piecesToFlip = []){
  let x = pos[0] + dir[0];
  let y = pos[1] + dir[1];
  let newPos = [x, y];
  if (this.isValidPos(newPos) === false){return []}
  let newPiece = this.getPiece(newPos);
  if (newPiece === undefined) { return []} 
  else if (newPiece.color === color) {return piecesToFlip}
  else if (newPiece.color != color) {
    piecesToFlip.push(newPos);
    return this._positionsToFlip(newPos, color, dir, piecesToFlip);
    }
}


/**
 * Checks that a position is not already occupied and that the color
 * taking the position will result in some pieces of the opposite
 * color being flipped.
 */
Board.prototype.validMove = function (pos, color) {
  let piece = this.grid[pos[0]][pos[1]]
  if (piece != undefined){
    return false;
  }
  let result = false
  Board.DIRS.forEach((dir) => {
    if (this._positionsToFlip(pos, color, dir, piecesToFlip = []).length > 0) {
      result = true;
    }
  })
  return result;
};

/**
 * Adds a new piece of the given color to the given position, flipping the
 * color of any pieces that are eligible for flipping.
 *
 * Throws an error if the position represents an invalid move.
 */
Board.prototype.placePiece = function (pos, color) {
  if (!this.validMove(pos, color)){ throw new Error('Invalid move!')}
  this.grid[pos[0]][pos[1]] = new Piece(color)
  Board.DIRS.forEach((dir) => {
    this._positionsToFlip(pos, color, dir).forEach((p)=>{
      this.grid[p[0]][p[1]].flip()
    });
  });
}

/**
 * Produces an array of all valid positions on
 * the Board for a given color.
 */
Board.prototype.validMoves = function (color) {
  let result = [];
  for (let i = 0; i < 8; i++){
    for (let j = 0; j < 8; j++){
      let p = [i,j];
      if (this.validMove(p, color) && !result.includes(p)){
        result.push(p);
      }
    }
  }
  return result;
};

/**
 * Checks if there are any valid moves for the given color.
 */
Board.prototype.hasMove = function (color) {
  if(this.validMoves(color).length > 0){return true} else {return false}
};



/**
 * Checks if both the white player and
 * the black player are out of moves.
 */
Board.prototype.isOver = function () {
  if (this.hasMove('white') || this.hasMove('black')){
    return false;
  }
  return true
};




/**
 * Prints a string representation of the Board to the console.
 */
Board.prototype.print = function () {
  this.grid.forEach((row) => {
    console.log(row.join(" | "))
    // row.forEach((piece) => {
    //   if (piece) { console.log(piece.toString()) 
    //   } else { 
    //     console.log("*") }
    // })
  })
}


// DON'T TOUCH THIS CODE
if (typeof window === 'undefined'){
  module.exports = Board;
}
// DON'T TOUCH THIS CODE