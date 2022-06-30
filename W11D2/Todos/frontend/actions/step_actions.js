export const RECEIVE_STEPS = "RECEIVE_STEPS";
export const RECEIVE_STEP = "RECEIVE_STEP";
export const REMOVE_STEP = "REMOVE_STEP";
export const UPDATE_STEP_STATUS = "UPDATE_STEP_STATUS";

export const receiveSteps = (steps) => {
    return {
        type: RECEIVE_STEPS,
        steps
    };
};

window.receiveSteps = receiveSteps;

export const receiveStep = (step) => ({
    type: RECEIVE_STEP,
    step
});

window.receiveStep = receiveStep;

export const removeStep = (id) => ({
    type: REMOVE_STEP,
    id
})

window.removeStep = removeStep;

export const updateStepStatus = (id) => {
    return {
        type: UPDATE_STEP_STATUS,
        id
    };
};

window.updateStepStatus = updateStepStatus;



