import React from 'react';
import { Link } from 'react-router-dom';

const Item  = ({item}) =>{
    return(
        <li>
            <Link to={`/pokemon/${item.pokemonId}/items/${item.id}`}>
                <img src= {item.imageUrl} alt="" />
            </Link>
        </li>
    )
}

export default Item;