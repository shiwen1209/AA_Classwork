export const RECEIVE_TODOS = "RECEIVE_TODOS";
export const RECEIVE_TODO = "RECEIVE_TODO";
export const REMOVE_TODO = "REMOVE_TODO";
export const UPDATE_TODO_STATUS = "UPDATE_TODO_STATUS";

export const receiveTodos = (todos) => {
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
    return {
        type: UPDATE_TODO_STATUS,
        id
    };
};

window.updateTodoStatus = updateTodoStatus;

