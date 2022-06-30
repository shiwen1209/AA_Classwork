class Store {
    constructor(rootReducer){
        this.rootReducer = rootReducer;
        this.state = {
            user: "Andy",
            role: "Instructor"
        };
        this.getState = this.getState.bind(this)

    }


    getState(){
        const copy = Object.assign({}, this.state);
        return copy;
    }
}


const action1 = {
    type: "change role",
    newRole: "Student"
};

const action2 = {
    type: "update user name",
    newUserName: "Jeremy"
}


const roleReducer = (oldRole = null, action) => {
    if (action.type === "change role") {
        return action.newRole;
    } else {
        return oldRole;
    }
};

const userReducer = (oldUser = null, action) => {
    if (action.type === "update user name") {
        return action.newUserName;
    } else {
        return oldUser;
    }
};

const store = new Store(roleReducer);

const prevState1 = store.getState().role
const prevState2 = store.getState().user;

console.log(roleReducer(prevState1, action1));

console.log (userReducer(prevState2, action2));




