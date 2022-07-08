import { RECEIVE_BENCHES } from "../actions/bench_actions";

const benchesReducer = (state={}, action) => {
    Object.freeze(state);
    let nextState = {};
    switch (action.type) {
        case RECEIVE_BENCHES:
            action.benches.forEach(bench => {
                nextState[bench.id] = bench
            });
            return nextState
        default:
            return state;
    }

}

export default benchesReducer