import { connect } from "react-redux";
import { logout } from "../../actions/session_actions";
import Greeting from "./greeting";

const mapStateToProps = (state) => {
    return {
        currentUser: state.entities.users[state.session.id]
    }
}

const mapDispatchToProps = (dispatch) => {
    console.log("action dispatched")
    return {
        logout: ()=>dispatch(logout()) // action inside dispatch must be invoked
    }
}

const GreetingContainer = connect(mapStateToProps, mapDispatchToProps)(Greeting)

export default GreetingContainer;

