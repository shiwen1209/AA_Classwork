import React from "react";
import BenchIndexItem from "./bench_index_item"

class BenchIndex extends React.Component {
    componentDidMount() {
        this.props.fetchBenches()
    }

    render() {
        const benchlist = this.props.benches.map((bench, idx)=>{
            return <BenchIndexItem key = {idx} bench = {bench}/>
        }) 

        return (
            <div>
                <ul>
                    {benchlist}
                </ul>

            </div>
        )
    }
}

export default BenchIndex