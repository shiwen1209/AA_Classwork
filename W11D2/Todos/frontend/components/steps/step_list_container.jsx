import { connect } from "react-redux";
import {receiveStep} from "../../actions/step_actions";
import StepList from "./step_list";
import Selectors from "../../reducers/selectors"


const mapStateToProps = (state, ownProps) => {
    // console.log("abc");
    // console.log(stepsByTodoId);
    return {
    steps: Selectors.stepsByTodoId(state, ownProps.todo_id),
    todo_id: ownProps.todo_id
    }
};

const mapDispatchToProps = dispatch => ({
    receiveStep: step => dispatch(receiveStep(step))
});

export default connect(
    mapStateToProps,
    mapDispatchToProps
)(StepList);