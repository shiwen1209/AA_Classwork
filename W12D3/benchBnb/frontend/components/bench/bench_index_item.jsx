import React from "react";

const BenchIndexItem = (props)=>{
    return(
        <li>
            <p>{props.bench.id}</p>
            <p>{props.bench.description}</p>
            <p>{props.bench.lat}</p>
            <p>{props.bench.lng}</p>
        </li>
    )
}

export default BenchIndexItem;