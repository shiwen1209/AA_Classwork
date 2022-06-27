import React from 'react';
import ReactDOM from 'react-dom';
import * as Minesweeper from "../minesweeper.js";
import Board from "./board";

export default class Game extends React.Component{
    
    constructor(props){
        super(props);
        const newBoard = new Minesweeper.Board(9, 10)
        this.state = {board: newBoard}
        this.updateGame = this.updateGame.bind(this);
        this.render = this.render.bind(this);
    }

    updateGame(tile, isFlagging){
        console.log("updateGame")
        if(isFlagging){
            tile.toggleFlag()
        }else {
            tile.explore()
        }
        
        this.setState({ board: this.state.board })
        
        const modal = document.getElementsByClassName("modal");
        
        
        if(this.state.board.won()){
            modal[0].className = "modal is-open";
            ReactDOM.render(<p>You Won!</p>, document.getElementById("game-over"))
            this.setState({board:new Minesweeper.Board(9, 10)})
        }else if (this.state.board.lost()){
            modal[0].className = "modal is-open";
            ReactDOM.render(<p>You Lost!</p>, document.getElementById("game-over"))
            this.setState({board:new Minesweeper.Board(9, 10)})
        } 
        
    }

    render(){
        return (
            <div>
                <h1>Minesweeper</h1>
                <Board  board = {this.state.board} game = {this.updateGame}/>
            </div>
        )
    }
    
}
