import React, { Component } from "react";
import { connect } from "react-redux";
import { Route, Redirect, withRouter } from "react-router-dom";


const mapStateToProps = state => ({
    loggedIn: Boolean(state.session.currentUser)
})

// <AuthRoute path = "" component={} />
const Auth = ({loggedIn, path, component: Component}) => (
    <Route
        path = {path}
        render = {props => (
            loggedIn ? <Redirect to = "/" /> : <Component {...props} />
        )}
    />
)

export const AuthRoute = withRouter(connect(mapStateToProps)(Auth));

const Protected = ({ loggedIn, path, component: Component }) => (
    <Route
        path={path}
        render={props => (
            loggedIn ? <Component {...props} /> : <Redirect to="/signup" />
        )}
    />
)

export const ProtectedRoute = withRouter(connect(mapStateToProps)(Protected))