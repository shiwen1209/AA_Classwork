
import ReactDOM from "react-dom";
import React from "react";
import Clock from "./clock";
import Tabs from "./tabs";
import Autocomplete from "./autocomplete";

const arr =[{ title: "one", content: "I'm the first" }, { title: "two", content: "Second pane here" }, { title: "three", content: "third pane here" }]
const names = ['Abba',
  'Barney',
  'Barbara',
  'Jeff',
  'Jenny',
  'Sarah',
  'Sally',
  'Xander']

function Root(){
  return (
    <div>
      <Clock />
      <Tabs arr= {arr} />
      <Autocomplete names={names} />
    </div>
  )
}

document.addEventListener("DOMContentLoaded", ()=> {
  const root = document.getElementById("root")

  ReactDOM.render(<Root  />, root);




})

