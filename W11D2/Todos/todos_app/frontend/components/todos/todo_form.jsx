import React from 'react';
// import uniqueId from "../util";

export default class TodoForm extends React.Component {
    constructor(props){
        super(props);
        this.state = {title: "", body: "", done: false};
        this.updateTitle = this.updateTitle.bind(this);
        this.updateBody = this.updateBody.bind(this);
        this.updateTodo = this.updateTodo.bind(this);
    }

    updateTitle(event) {
        this.setState({ title: event.currentTarget.value });
    }

    updateBody(event) {
        this.setState({ body: event.currentTarget.value });
    }

    updateTodo(event){
        this.props.createTodo(this.state)
        .then(() => this.setState({ title: '', body: '' }));
    }


    render() {
            return (
                <div className='form'>
                    <div className='todo-form'>
                        <label htmlFor="title">Title</label>
                        <input id="title" onChange={this.updateTitle} value={this.state.title} />
                    </div>
                 
                    <div className='todo-form'>
                        <label htmlFor="body">Body</label>
                        <input id="body" type = "text" onChange={this.updateBody} value={this.state.body} />
                    </div>

                    <div>
                        <input className="create" type="submit" onClick = {this.updateTodo} value = "Create todo"/>
                    </div>
                </div>
            );
    }

}