
Function.prototype.myThrottle = function (interval) {
    let tooSoon = false
    let that = this
    return function(){
        if (tooSoon === false) {
            tooSoon = true;
            setTimeout(() => {
                tooSoon = false;
                that();
            }, interval);
     
    }
}
}

myMethod = function () { console.log("hello") };
myMethod = myMethod.myThrottle(5000)
const interval = setInterval(() => {
    myMethod();
}, 1000);


// class Neuron {
//     fire() {
//         console.log("Firing!");
//     }
// }

// const neuron = new Neuron();

// neuron.fire = neuron.fire.myThrottle(5000);

// const interval = setInterval(() => {
//     neuron.fire();
// }, 1000);
