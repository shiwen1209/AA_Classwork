import React from 'react';
import PokemonIndexItem from './pokemon_index_item';
import { Route, Switch, Redirect } from 'react-router-dom';
import PokemonDetailContainer from './pokemon_detail_container';


class PokemonIndex extends React.Component{
  constructor(props){
  super(props)
  }
  
  componentDidMount(){
  this.props.requestAllPokemon()
  }
  
  render(){
    const pokemonItems = this.props.pokemon.map(poke => (
      <PokemonIndexItem key={poke.id} pokemon={poke} />
    ));
    return (
    // And inside the render:
    <section className = "pokedex" >
        <Route path="/pokemon/:pokemonId" component={PokemonDetailContainer}></Route>;
            <ul>{pokemonItems}</ul>
    </section>

    )
  }
  }
  
  
  
  export default PokemonIndex;