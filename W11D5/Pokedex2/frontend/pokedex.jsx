import React from 'react';
import ReactDOM from 'react-dom';
import { receiveAllPokemon } from './actions/pokemon_actions';
import { fetchAllPokemon } from './util/api_util';
import configureStore from './store/store'

document.addEventListener('DOMContentLoaded', () => {
    const rootEl = document.getElementById('root');

    const store = configureStore();

    window.store = store; 
    

    ReactDOM.render(<h1>Pokemon</h1>, rootEl);



    
  });