export const RECEIVE_TODOS = "RECEIVE_TODOS";
export const RECEIVE_TODO = "RECEIVE_TODO";
export const REMOVE_TODO = "REMOVE_TODO";
export const UPDATE_TODO_STATUS = "UPDATE_TODO_STATUS";
import * as APIUtil from "../util/todo_api_util";

export const receiveTodos = (todos) => {
    console.log (todos)
    return {
        type: RECEIVE_TODOS,
        todos
    };
};

window.receiveTodos = receiveTodos;

export const receiveTodo = (todo) => {
    console.log("receive todo")
    return {
    type: RECEIVE_TODO,
    todo
    }
};

window.receiveTodo = receiveTodo;

export const removeTodo = (id)=>({
    type: REMOVE_TODO,
    id
})

window.removeTodo = removeTodo;

export const updateTodoStatus = (id) => {
    console.log("action is triggered")
    return {
        type: UPDATE_TODO_STATUS,
        id
    };
};

window.updateTodoStatus = updateTodoStatus;


export const fetchTodos = ()=>dispatch=> {
    return APIUtil.fetchTodos().then((todos)=> dispatch(receiveTodos(todos)))
}

window.fetchTodos = fetchTodos;


export const createTodo = (todo) => dispatch => {
    return APIUtil.createTodo(todo).then((todo) => dispatch(receiveTodo(todo)))
}

window.createTodo = createTodo;