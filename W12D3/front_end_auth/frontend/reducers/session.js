import { RECEIVE_CURRENT_USER, LOGOUT_CURRENT_USER } from "../actions/session";

const _nullSession = {
    currentUser: null
}

export default (state = _nullSession, action)=> {
    console.log("session reducer hit")
    Object.freeze(state);
    switch (action.type) {
        case RECEIVE_CURRENT_USER:
            console.log("receive current user")
            console.log(action.user)
            return Object.assign({}, {currentUser: action.user});  // forget to return
        case LOGOUT_CURRENT_USER:
            return _nullSession;        
        default:
            return state
    }
}