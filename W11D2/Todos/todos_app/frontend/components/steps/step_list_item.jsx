import React from 'react';

export default class StepListItem extends React.Component{
    constructor(props){
        super(props);
        this.removeStep = this.removeStep.bind(this);
    }

    removeStep(e){
        this.props.removeStep(this.props.step.id);
    }

    render(){
        return (
            <li>
                <div>
                    <h3>{this.props.step.title}</h3>
                    <p>{this.props.step.body}</p>
                </div>

                <div>
                    <button >Done</button>
                    <button className="delete-button" onClick={this.removeStep}>Delete</button>
                </div>
            </li>
        )

    }
}