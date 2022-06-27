import React from 'react';
import ReactDOM from 'react-dom';
import Tile from './tile.jsx';
import * as Minesweeper from "../minesweeper.js";


export default class Board extends React.Component{
    constructor(props){
        super(props);
    }

    render(){
        return (
            <div className="board">
                {this.props.board.grid.map((row, i) => {return (
                    <div className='row' key ={i}> 
                        {row.map((tile, j) => <Tile key ={[i,j]} tile={tile} game = {this.props.game} />)}
                    </div>
                    
                )})}
            </div>
        )
    }
}