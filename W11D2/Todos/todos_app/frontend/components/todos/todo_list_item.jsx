import React from 'react';
import TodoDetailView from './todo_detail_view';

export default class TodoListItem extends React.Component {
    constructor(props){
        super(props);
        this.state = {detail: false}
        this.removeTodo = this.removeTodo.bind(this);
        this.updateTodoStatus = this.updateTodoStatus.bind(this);
        this.displayDetail = this.displayDetail.bind(this);

    }

    removeTodo(e){
        this.props.removeTodo(this.props.todo.id)

    }

    updateTodoStatus(e){
        this.props.updateTodoStatus(this.props.todo.id)
    }

    displayDetail(e){
        if (this.state.detail) {
            this.setState({ detail: false })
        } else {
            this.setState({ detail: true })
        }
    }

    render(){
        return (
            <li>
                <div className='todo-item'>
                    <h3 onClick={this.displayDetail}>{this.props.todo.title}</h3>
                    <button onClick={this.updateTodoStatus}>{this.props.todo.done ? "undone" : "done"}</button>
                </div>

                <div>
                    {this.state.detail ? <TodoDetailView todo={this.props.todo} /> : <p></p>}
                </div>

               
                
            </li>
        )
    }
}