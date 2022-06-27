import React from "react";

class Clock extends React.Component{
 constructor(props){
   super(props); // gives us access to 'this' inside constructor
   this.state = {
     date: new Date() // .toString makes a string
   }
   this.tick = this.tick.bind(this)
 }
 
tick() {
  this.setState({date: new Date()})
 }
 
componentDidMount(){
  this.intID = setInterval( this.tick , 1000)
}

componentWillUnmount(){
 clearInterval(this.intID)
}


 render(){
   return (
     <div className= "clockmodule">
      <h1>Clock </h1>
       <div className="clock">

        <div class="inside-clock">
       <p>Time: </p> <p> {this.state.date.getHours()} : {this.state.date.getMinutes()} : {this.state.date.getSeconds()} PDT </p>
         </div>
       {/* <p>Date: {this.state.date.getDay} {this.state.date.getMonth()} {this.state.date.getUTCDate()} </p> */}
         <div class="inside-clock">
       <p>Date:  </p>
           <p>{this.state.date.toDateString()}</p>
       </div>
  
      </div>
    </div>
   )
 }

}

export default Clock;