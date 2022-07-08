import React from "react";
import {Link} from "react-router-dom";

class Greeting extends React.Component {
    constructor(props){
        super(props);
        this.handleClick = this.handleClick.bind(this)
    }

    handleClick(e){
        console.log("logout button clicked")
        this.props.logout()
    }

    render(){
        return(
            <nav>
                {this.props.currentUser ? 
                <div>
                    <h1>Welcome, {this.props.currentUser.username}</h1>
                    <button onClick={this.handleClick}>logout</button>
                </div> :

                <div>
                    <Link to="/signup">Sign Up</Link>
                        &nbsp;or&nbsp;
                    <Link to="/login">Login</Link>
                </div>
                }
            </nav>
            
        )
    }
}
export default Greeting;