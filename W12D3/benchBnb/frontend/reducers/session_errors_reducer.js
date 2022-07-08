import { RECEIVE_ERRORS, RECEIVE_CURRENT_USER } from "../actions/session_actions"

const sessionErrorsReducer = (state=[], action)=>{
    Object.freeze(state);
    switch (action.type) {
        case RECEIVE_ERRORS:
            return [action.errors]; // return an array of errors (then assinged to session key in errors state)
        case RECEIVE_CURRENT_USER:
            return [];
        default:
            return state;
    }
}

export default sessionErrorsReducer; 

// using a named function makes debugging a lot easier, 
// using export default anounymos function make debugging hard, as the console doesnt
// tell you where the error is
