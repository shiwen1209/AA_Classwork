import React from 'react';
import uniqueId from "../util";

export default class StepForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = { title: "", done: false };
        this.updateTitle = this.updateTitle.bind(this);
        this.updateStep = this.updateStep.bind(this);
    }

    updateTitle(event) {
        this.setState({ title: event.currentTarget.value });
    }

    updateStep(event) {
        const newStep = {
            id: uniqueId(),
            title: this.state.title,
            done: false,
            todo_id: this.props.todo_id
        }

        this.props.receiveStep(newStep)

    }


    render() {
        return (
            <div className='step-form'>
                <div id="step-form">
                    <label htmlFor="title">Title</label>
                    <input id="title" onChange={this.updateTitle} value={this.state.title} />
                </div>

                <input className="create" type="submit" onClick={this.updateStep} value="Create step" />
  
            </div>
        );
    }

}