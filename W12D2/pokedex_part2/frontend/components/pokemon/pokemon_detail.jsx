import React from "react";
import Item from '../items/item';
import { Route, Switch, Redirect } from 'react-router-dom';
import ItemDetailContainer from '../items/item_detail_container';


class PokemonDetail extends React.Component {

    componentDidMount() {
         
        console.log("abc")
        console.log(this.props.match.params.pokemonId)
        this.props.requestSinglePokemon(this.props.match.params.pokemonId)
    }

    componentDidUpdate(prevProps) {
        console.log("efg")
        console.log(this.props.match.params.pokemonId)
        if (prevProps.match.params.pokemonId !== this.props.match.params.pokemonId) {
            this.props.requestSinglePokemon(this.props.match.params.pokemonId)
        }
    }

    render(){
        console.log(this.props)
        if(!this.props.pokemon){
            return null;
        }
        return (
            <section className="pokemon-detail">
                <figure>
                    <img src={this.props.pokemon.imageUrl} alt={this.props.pokemon.name} />
                </figure>
                <ul>
                    <li><h2>{this.props.pokemon.name}</h2></li>
                    <li>Type: {this.props.pokemon.pokeType}</li>
                    <li>Attack: {this.props.pokemon.attack}</li>
                    <li>Defense: {this.props.pokemon.defense}</li>
                    <li>Moves: {this.props.moves.join(', ')}</li>
                    <li></li>
                </ul>

                <section className="toys">
                    <h3>Items</h3>
                    <ul className="toy-list">
                        {this.props.items.map(item => <Item key={item.name} item= {item} />)}
                    </ul>
                </section>

                <Route path="/pokemon/:pokemonId/items/:itemId" component={ItemDetailContainer} ></Route>


            </section>

        )

    }

}

export default PokemonDetail;