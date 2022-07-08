import React from "react";
import { Link } from "react-router-dom";

class SessionForm extends React.Component {
    constructor(props){
        super(props);
        this.state = {
            username: "",
            password: ""
        }
        this.handleSubmit = this.handleSubmit.bind(this)
    }

    handleSubmit(e){
        e.preventDefault();
        this.props.processForm(this.state)
    }

    update(field){
        return (e)=> this.setState({[field]: e.currentTarget.value })
    }

    
    render(){
        return(
            <div>
                {this.props.formType === "signup" ?
                    <Link to="/login">Login</Link> :
                    <Link to="/signup">Sign Up</Link> 
                }
                
                &nbsp;&nbsp;&nbsp;&nbsp;
                <Link to="/">Home</Link>

                <p>{this.props.errors}</p>
      
                <form onSubmit={this.handleSubmit}>
                    <label>Username:
                        <input type="text" 
                                value={this.state.username}
                                onChange={this.update("username")} />
                    </label>
                    <label>Password:
                        <input type="password"
                            value={this.state.password}
                            onChange={this.update("password")} />
                    </label>
                    <button>{this.props.formType}</button>
                </form>

                
            </div>
        )
    }
}

export default SessionForm