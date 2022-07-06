export const fetchAllPokemon = () =>{
    return $.ajax({
         url:'/api/pokemon',
         method: 'GET'
    })
}

window.fetchAllPokemon = fetchAllPokemon;