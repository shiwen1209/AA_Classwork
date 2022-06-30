import { RECEIVE_TODOS, RECEIVE_TODO, REMOVE_TODO, UPDATE_TODO_STATUS } from "../actions/todo_actions"

const initialState = {
    1: {
        id: 1,
        title: "wash car",
        body: "with soap",
        done: false
    },
    2: {
        id: 2,
        title: "wash dog",
        body: "with shampoo",
        done: true
    }
};



const todosReducer = (state = initialState, action)=>{
    Object.freeze(state);
    let nextState;
    switch (action.type) {
        case RECEIVE_TODOS:
            nextState = {}
            action.todos.forEach((todo) => {
                nextState[todo.id] = todo;
            });
            return nextState;
        case RECEIVE_TODO:
            nextState = Object.assign({}, state );
            nextState[action.todo.id] = action.todo;
            return nextState;
        case REMOVE_TODO:
            nextState = Object.assign({}, state);
            delete nextState[action.id]
            return nextState;
        case UPDATE_TODO_STATUS:
            nextState = Object.assign({}, state);
            if (nextState[action.id].done){
                nextState[action.id].done = false;
            } else {
                nextState[action.id].done = true;
            }
            return nextState;
        default:
            return state;
    }

} 

export default todosReducer;

