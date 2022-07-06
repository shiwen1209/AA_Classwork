// import React from "react";

const allTodos = (state)=>{
    return Object.values(state.todos)
};

window.allTodos = allTodos; 


const stepsByTodoId = (state, todoId)=>{
    const arr = [];
    Object.values(state.steps).forEach((step)=>{
        if (step.todo_id === todoId){   
            arr.push(step);
        }
    })
    return arr; 
}

window.stepsByTodoId = stepsByTodoId; 

export default {allTodos, stepsByTodoId};

