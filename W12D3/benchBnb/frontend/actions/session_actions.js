import * as SessionApiUtil from "../util/session_api_util";

export const RECEIVE_CURRENT_USER = "RECEIVE_CURRENT_USER";
export const LOGOUT_CURRENT_USER = "LOGOUT_CURRENT_USER";
export const RECEIVE_ERRORS = "RECEIVE_ERRORS";

const receiveCurrentUser = (currentUser)=>({
    type: RECEIVE_CURRENT_USER,
    currentUser
})

const logoutCurrentUser = ()=>({
    type: LOGOUT_CURRENT_USER
})

const receiveErrors = (errors)=>{
    console.log("receive errors action")
    return {
    type: RECEIVE_ERRORS,
    errors
}}

export const login = (user)=> dispatch =>(
    SessionApiUtil.login(user)
    .then(
        (payload)=>dispatch(receiveCurrentUser(payload)),
        (err) => dispatch(receiveErrors(err.statusText))
    )
)

export const signup = (user)=> dispatch =>(
    SessionApiUtil.signup(user)
    .then(
        (payload)=>dispatch(receiveCurrentUser(payload)),
        (err) =>dispatch(receiveErrors(err.statusText))
    )
)

export const logout = ()=> dispatch=>{
    console.log("logging out")
    return SessionApiUtil.logout()
    .then(()=>dispatch(logoutCurrentUser()))
}