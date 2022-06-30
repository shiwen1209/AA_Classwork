import React from 'react';
import StepListItemContainer from "./step_list_item_container";
import StepForm from "./step_form"

const StepList = (props) => {
    // console.log(props);

    return (
   
            <ul className='step'>
                {props.steps.map((step, idx) => (
                    <StepListItemContainer key={idx} step={step} removeStep={props.removeStep} />
                ))}
                <StepForm todo_id={props.todo_id} receiveStep={props.receiveStep} />
            </ul>


    )

}

export default StepList;

