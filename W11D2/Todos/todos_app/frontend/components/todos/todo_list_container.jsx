import { connect } from "react-redux";
import { receiveTodo, removeTodo, updateTodoStatus, createTodo } from "../../actions/todo_actions";
import TodoList from "./todo_list";

const mapStateToProps = state => ({
    todos: allTodos(state)
});

const mapDispatchToProps = dispatch => ({
    receiveTodo: todo => dispatch(receiveTodo(todo)),
    removeTodo: todo => dispatch(removeTodo(todo)),
    updateTodoStatus: id=> dispatch(updateTodoStatus(id)),
    createTodo: todo=>dispatch(createTodo(todo))
});

export default connect(
    mapStateToProps,
    mapDispatchToProps
)(TodoList);