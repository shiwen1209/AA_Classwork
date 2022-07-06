import ReactDOM from "react-dom";
import React from "react";
import configureStore from "./store/store";
import Root from "./components/root";
import { allTodos, stepsByTodoId } from "./reducers/selectors";
import {fetchTodo} from "./util/todo_api_util";

document.addEventListener("DOMContentLoaded", () => {

    let store = configureStore();
    
    window.store = store;
    
    const root = document.getElementById("root");


    // Phase 1
    // const addLoggingToDispatch = store => {
    //     const dispatch = store.dispatch;
    //     return (action) => {
    //         console.log(store.getState());
    //         console.log(action);
    //         dispatch(action);
    //         console.log(store.getState());
    //     }
    // }

    // store.dispatch = addLoggingToDispatch(store)

    //Phase 2
    // const addLoggingToDispatch = store => next => action => {
    //         console.log(store.getState());
    //         console.log(action);
    //         next(action);
    //         console.log(store.getState());
    // }

    // const applyMiddlewares = (store, ...middlewares) =>{
    //     let dispatch = store.dispatch;
    //     middlewares.forEach((middleware)=>{
    //         dispatch = middleware(store)(dispatch)
    //     })
    //     return Object.assign({}, store, { dispatch })
    // }
    
    // store = applyMiddlewares(store, addLoggingToDispatch);

    
    
    ReactDOM.render(<Root store = {store}/>, root )



});