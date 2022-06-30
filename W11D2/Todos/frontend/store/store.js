import { legacy_createStore as createStore } from "redux";
import rootReducer from "../reducers/root_reducer";
import { applyMiddleware } from "redux";

const addLoggingToDispatch = store => next => (action) => {
        console.log("next");
        console.log(next);
        console.log(store.getState());
        console.log(action);
        next(action);
        console.log(store.getState());
    }

const anotherMiddleware = store => next => action => {
    console.log("just testing")
        
    }


const configureStore = (preloadedState = {}) => {
    if(window.localStorage["store"]){
        preloadedState = JSON.parse(window.localStorage["store"])
    }
    const store =  createStore(rootReducer, preloadedState, 
        applyMiddleware(addLoggingToDispatch, anotherMiddleware));
    store.subscribe(()=>{
        const newState = store.getState();
        window.localStorage.setItem("store", JSON.stringify(newState)) 
        // how is this able to save all changes to local storage? 
        // because subsribe is called every time an action is dispatched
    });
    return store;
}

export default configureStore;