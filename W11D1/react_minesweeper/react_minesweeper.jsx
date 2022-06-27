import React from 'react';
import ReactDOM from 'react-dom';
import Game from './components/game.jsx';

document.addEventListener("DOMContentLoaded",()=>{
    const root = document.getElementById("root")
    console.log(root)


    console.log(Game)
    ReactDOM.render( <Game />, root)

    const modal = document.getElementsByClassName("modal");
    console.log(modal[0]);
    const closeElements = document.querySelectorAll(".js-modal-close");
    console.log(closeElements);
    closeElements.forEach((ele)=>{
        console.log(ele);
        ele.addEventListener("click", (e)=>{ 
            console.log(modal[0]);
            modal[0].classList.remove("is-open")})
    }

    

    )




})