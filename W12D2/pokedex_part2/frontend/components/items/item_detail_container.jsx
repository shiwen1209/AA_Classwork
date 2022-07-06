import { connect } from 'react-redux';
// import { requestSinglePokemon } from './../../actions/pokemon_actions';
// import { selectPokemonMovesNames } from './../../reducers/selectors';
import ItemDetail from './item_detail.jsx';


const mapStateToProps = (state, ownProps) => {
    console.log("map item")
    return {
    item: state.entities.items[ownProps.match.params.itemId],
}}

// const mapDispatchToProps = dispatch => ({
//     requestSinglePokemon: (id) => dispatch(requestSinglePokemon(id))
// })

export default connect(mapStateToProps)(ItemDetail)