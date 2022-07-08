import React from "react";
import App from "./app";
import { Provider } from "react-redux";
import { HashRouter } from "react-router-dom";

const Root = ({store})=> {
    console.log("Root")
    return (
        <Provider store={store}>
            <HashRouter>
                <App />
            </HashRouter>
        </Provider>
    )
}



export default Root