import {legacy_createStore as createStore} from 'redux';
import { applyMiddleware } from 'redux'; 
import rootReducer from '../reducers/root_reducer';
import logger from 'redux-logger';
import thunk from '../middleware/thunk';

const configureStore = () => {
    return createStore(
        rootReducer,
        applyMiddleware(thunk, logger) // logger should go after thunk, so that it logs normal actions
    );
}

export default configureStore;
