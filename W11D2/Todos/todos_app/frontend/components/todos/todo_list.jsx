import React from 'react';
import TodoListItem from "./todo_list_item";
import TodoForm from "./todo_form"

const TodoList =  (props) =>{

    return (
        <div>


            <h1>Wendy's Super Awesome Todo List </h1>

            <div>
                <TodoForm receiveTodo={props.receiveTodo}
                            createTodo = {props.createTodo} />
            </div>


                <ul className="todo">
                    {props.todos.map((todo, idx) => (
                    <TodoListItem key={idx} 
                                todo={todo} 
                                removeTodo={props.removeTodo} 
                                updateTodoStatus = {props.updateTodoStatus}/>
                    ))}
                </ul>
    

        </div>
    )

}  

export default TodoList

