import { combineReducers } from "redux";
import { entitiesReducer } from "./entity_reducer";

const rootReducer = combineReducers({
    entities: entitiesReducer
});
export default rootReducer