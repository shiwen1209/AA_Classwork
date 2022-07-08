import React from "react";
import GreetingContainer from "./greeting/greeting_container";
import { Route, Switch } from "react-router-dom";
import LoginFormContainer from "./session_form/login_form_container";
import SignupFormContainer from "./session_form/signup_form_container";
import { AuthRoute, ProtectedRoute } from "../util/route_util";
import SearchContainer from "./bench/search_container";

const App = ()=> {
    console.log("App")
    return (
        <div>
            <h1>Bench BnB</h1>
            <GreetingContainer />
            <Switch>
                <AuthRoute path="/signup" component={SignupFormContainer} />
                <AuthRoute path="/login" component={LoginFormContainer} />
                <Route exact path="/" component={SearchContainer} />
            </Switch>
        </div>
    )
}

export default App; 