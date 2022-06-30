import React from 'react';
import StepListContainer from '../steps/step_list_container';

export default class TodoDetailView extends React.Component {
    constructor(props) {
        super(props);
    }



    render() {
        return (
            <div>
                <div><p>{this.props.todo.body}</p></div>
                <div id="step-container">
                    <StepListContainer todo_id = {this.props.todo.id} /> 
                </div>
                <button className='delete-button'>Delete</button>
            </div>
            
                
        
        )
    }
}