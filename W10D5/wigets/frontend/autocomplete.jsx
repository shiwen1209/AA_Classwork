import React from "react";


export default class Autocomplete extends React.Component {
    constructor (props) {
        super(props);
        this.state = {inputVal: ""};
        this.handleInput = this.handleInput.bind(this);

    }

    handleInput(e){
        this.setState({inputVal: e.currentTarget.value })
    }

    render(){
        const names = this.props.names.map((name, idx)=><li 
        key= {idx}
        onClick = {(e)=> {this.setState({inputVal: e.currentTarget.innerText })}}
        >{name}</li>)

        return (
            <div>
                <h1>Autocomplete</h1>
                <input type="text"
                        onChange={this.handleInput}
                        value = {this.state.inputVal}
                        placeholder = "Searching..." />
                <ul>

                    {names}

                </ul>
            </div>
        )
    }

}