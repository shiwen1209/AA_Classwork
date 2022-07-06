import React from "react";


class PokemonIndex extends React.Component {

    componentDidMount(){
        debugger
        this.props.requestAllPokemon()
    }

    render (){
        const pokemons = this.props.pokemon.map((pokemon, idx) => {
            return (
            <li key={idx}>
                <div>{pokemon.name}</div>
                <img src={pokemon.imageUrl} alt="" />
            </li>
        )})

        return (
            <ul>
                {pokemons}
            </ul>
        )
    }

}

export default PokemonIndex;