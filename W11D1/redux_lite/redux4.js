class Store {
    constructor(rootReducer) {
        this.rootReducer = rootReducer;
        this.state = {};
        this.subscriptions =[];
        this.getState = this.getState.bind(this)

    }

    getState() {
        const copy = Object.assign({}, this.state);
        return copy;
    }

    dispatch(action) {
        this.state = this.rootReducer(this.state, action, this.subscriptions);
    }

    subscribe(callback){
        this.subscriptions.push(callback)
    }

}

const createStore = (...args) => new Store(...args);


const combineReducers = (config) => {
    return (prevState, action, subscriptions) => {
        let nextState = {};
        Object.keys(config).forEach((k) => {
            if (!action) {
                const args = [, { type: "__initialize" }];
                nextState[k] = config[k](...args);
            } else {
                nextState[k] = config[k](prevState[k], action);
                if(nextState[k] != prevState[k]){
                    subscriptions.forEach((callback)=>callback(nextState))
                }
            }

        });
        return nextState;

    }
}


const actionCreator1 = value => ({
    type: "add",
    value
});

const actionCreator2 = value => ({
    type: "subtract",
    value
});

const actionCreator3 = value => ({
    type: "no change",
    value
});

const numberReducer = (num = 0, action) => {
    switch (action.type) {
        case "add":
            return num + action.value;
        case "subtract":
            return num - action.value;
        default:
            return num;
    }
}

const rootReducer = combineReducers({
    number: numberReducer
});

const store = new Store(rootReducer);

const a = store.getState() // => { number: 0 }
console.log(a)

const announceStateChange = nextState => {
    console.log(`That action changed the state! Number is now ${nextState.number}`);
}

store.subscribe(announceStateChange);

const b = store.dispatch(actionCreator1(5)); // => "That action changed the state! Number is now 5"
console.log(b)
const c = store.dispatch(actionCreator1(5)); // => "That action changed the state! Number is now 10"
console.log(c)
const d = store.dispatch(actionCreator2(7)); // => "That action changed the state! Number is now 3"
console.log(d)
const e = store.dispatch(actionCreator3(7)); // => Nothing should happen! The reducer doesn't do anything for type "no change"
console.log(e)
const f = store.dispatch(actionCreator1(0)) // => Nothing should happen here either. Even though the reducer checks for the "add" action type, adding 0 to the number won't result in a state change.
console.log(f)

const g = store.getState(); // => { number: 3 }
console.log(g)