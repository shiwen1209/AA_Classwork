import React from "react";
import { Link } from "react-router-dom";


class PokemonIndexItem extends React.Component{

       render(){
        
           return(
               <li key={this.props.pokemon.key} className="pokemon-index-item">
                <Link to={`/pokemon/${this.props.pokemon.id}`}>
                    <span>{this.props.pokemon.id}</span>
                    <img src={this.props.pokemon.imageUrl} alt="" />
                    <span>{this.props.pokemon.name}</span>
                </Link>
             </li>
           )
       }
}

export default PokemonIndexItem; 
