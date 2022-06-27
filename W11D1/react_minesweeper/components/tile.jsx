import React from 'react';
import ReactDOM from 'react-dom';

export default class Tile extends React.Component{

    constructor(props){
        super(props);
        this.handleClick = this.handleClick.bind(this)
    }

    handleClick(e){
        this.props.game(this.props.tile, e.altKey);
    }

    render(){
        return (
            <div className="tile" onClick={this.handleClick} style={this.props.tile.explored ? {borderStyle: "inset"}:{}}>
                {
                    this.props.tile.flagged ? <p style={{ color: "red"}}>&#x2691;</p> : !this.props.tile.explored ? <p style={{ color: "red" }}></p> : this.props.tile.bombed ? <p>&#128163;</p> : this.props.tile.adjacentBombCount() >0 ?  <p>{this.props.tile.adjacentBombCount()}</p> : <p></p>
                }
                
            </div>
        )
    }
}