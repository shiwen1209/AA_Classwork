class Store {
    constructor(rootReducer) {
        this.rootReducer = rootReducer;
        this.state = {
        };
        this.getState = this.getState.bind(this)

    }


    getState() {
        const copy = Object.assign({}, this.state);
        return copy;
    }

}


const combineReducers = (config)=> {
    return (prevState, action) => {
        let nextState = {};
        Object.keys(config).forEach((k)=>{
            nextState[k] = config[k](prevState[k], action);
        });
        return nextState;
      
    }
}


const myNoiseReducer = (prevState = "peace and quiet", action) => {
    switch (action.type) {
        case "noisy action":

            return action.noise;
        case "a type no one cares about":
            return action.data
        default:

            return prevState;
    }
};

const myNoisyAction = {
    type: "noisy action",
    noise: "Car alarm"
};

const myInconsequentialAction = {
    type: "a type no one cares about",
    data: {
        thisThing: "will not get used anyway"
    }
};

const myInitialState = {
    noise: "peace and quiet"
};

const myRootReducer = combineReducers({
    noise: myNoiseReducer,
});

let newState = myRootReducer(myInitialState, myInconsequentialAction);
// => { noise: "peace and quiet" }
console.log(newState);

newState = myRootReducer(newState, myNoisyAction)
// => { noise: "Car alarm" }

console.log(newState)