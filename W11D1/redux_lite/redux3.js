class Store {
    constructor(rootReducer) {
        this.rootReducer = rootReducer;
        this.state = {};
        this.getState = this.getState.bind(this)

    }

    getState() {
        const copy = Object.assign({}, this.state);
        return copy;
    }

    dispatch(action) {
        this.state = this.rootReducer(this.state, action);

    }
}

const createStore = (...args) => new Store(...args);


const combineReducers = (config) => {
    return (prevState, action) => {
        let nextState = {};
        Object.keys(config).forEach((k) => {
            if(!action){
                const args = [ , { type: "__initialize" }];
                nextState[k] = config[k](...args);
            } else {
                nextState[k] = config[k](prevState[k], action);
            }

        });
        return nextState;

    }
}



// define a reducer for user:
const userReducer = (oldUser = null, action) => {
    if (action.type === "new user") {
        return action.user;
    }
    return oldUser;
};

// create a rootReducer:
const rootReducer = combineReducers({
    user: userReducer
});

// create a store using the rootReducer:
const store = new Store(rootReducer);

// get the state:
store.getState(); // => {}

console.log(store.getState())

// invoke the dispatch function to update the user key:
const action = {
    type: "new user",
    user: "Jeffrey Fiddler"
};

store.dispatch(action);
store.getState(); // => { user: "Jeffrey Fiddler" }

console.log(store.getState())

