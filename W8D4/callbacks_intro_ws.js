// class Clock {
//     constructor() {

//       // 1. Create a Date object.
//         let initial_time = new Date()
//       // 2. Store the hours, minutes, and seconds.
//         this.hours = initial_time.getHours();
//         this.minutes = initial_time.getMinutes();
//         this.seconds = initial_time.getSeconds();
//       // 3. Call printTime.
//         this.printTime();
//       // 4. Schedule the tick at 1 second intervals.
//         // let that = this
//     
//     }
  
//     printTime() {
//       // Format the time in HH:MM:SS
//       // Use console.log to print it.
//       console.log(`${this.hours}:${this.minutes}:${this.seconds}`);
//     }
  
//     _tick() {
//       // 1. Increment the time by one second.
//       if (this.seconds < 59) {
//           this.seconds +=1
//       } else if (this.minutes < 59){
//           this.seconds = 0
//           this.minutes +=1
//       } else if(this.hours < 23){
//           this.seconds = 0
//           this.minutes = 0
//           this.hours += 1
//       } else {
//           this.seconds = 0
//           this.minutes = 0
//           this.hours = 0
//       }

      
//       // 2. Call printTime.

//       this.printTime();

//     }
//   }
  
//   const clock = new Clock();




// const readline = require("readline");
// const reader = readline.createInterface({
//     input: process.stdin,
//     output: process.stdout
// });

// function addNumbers(sum, numsLeft, completionCallback){
//     if (numsLeft > 0){
//         reader.question("Please input a number: ", (strNum) => {
//             num = parseInt(strNum);
//             sum += num;
//             console.log(`The new sum is ${sum}`);
//             numsLeft -= 1;
//             addNumbers(sum, numsLeft, completionCallback);
//         });
//     } else{
//         reader.close()
//         completionCallback(sum);
//     }
// }

// addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));




// Function.prototype.myBind = function (context) {
//         return () => {this.apply(context);}
// }


    

// class Lamp {
//     constructor() {
//         this.name = "a lamp";
//     }
//     }
    
//     const turnOn = function() {
//     console.log("Turning on " + this.name);
//     };
    
//     const lamp = new Lamp();
    
//     turnOn(); // should not work the way we want it to
    
//     const boundTurnOn = turnOn.bind(lamp);
//     const myBoundTurnOn = turnOn.myBind(lamp);
    
//     boundTurnOn(); // should say "Turning on a lamp"
//     myBoundTurnOn(); // should say "Turning on a lamp"




const { clear } = require("console")
let readline = require("readline")
let reader = readline.createInterface({
        input: process.stdin,
        output: process.stdout
})

// Write this first.
function askIfGreaterThan(el1, el2, callback) {
    // Prompt user to tell us whether el1 > el2; pass true back to the
    // callback if true; else false.
    reader.question(`Is ${el1} > ${el2}?`, (output) => {
        if (output === "yes"){
            callback(true)
        }else{
            callback(false)
        }
        //  innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop)

    })
  }

//   callback = function (input) {console.log(input)}
//   askIfGreaterThan(4,10,callback)
  
  // Once you're done testing askIfGreaterThan with dummy arguments, write this.
  function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
    // Do an "async loop":
    // 1. If (i == arr.length - 1), call outerBubbleSortLoop, letting it
    //    know whether any swap was made.
    // 2. Else, use `askIfGreaterThan` to compare `arr[i]` and `arr[i +
    //    1]`. Swap if necessary. Call `innerBubbleSortLoop` again to
    //    continue the inner loop. You'll want to increment i for the
    //    next call, and possibly switch madeAnySwaps if you did swap.
    // console.log("i:", i)
    if(i < arr.length - 1){
        askIfGreaterThan(arr[i], arr[i+1], function(isGreaterthan){
            if(isGreaterthan){
                [arr[i] , arr[i+1]] = [arr[i+1], arr[i]]
                madeAnySwaps = true;
            }
            i++    
            innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop)
        })
    } else if (i === arr.length - 1){
        // console.log("aa")
        outerBubbleSortLoop(madeAnySwaps)
    }
  }
  
  // Once you're done testing innerBubbleSortLoop, write outerBubbleSortLoop.
  // Once you're done testing outerBubbleSortLoop, write absurdBubbleSort.
  
  function absurdBubbleSort(arr, sortCompletionCallback) {
    function outerBubbleSortLoop(madeAnySwaps) {
      // Begin an inner loop if you made any swaps. Otherwise, call
    // `sortCompletionCallback`.
      if(madeAnySwaps){ 
          madeAnySwaps = false;
          innerBubbleSortLoop(arr, 0, madeAnySwaps, outerBubbleSortLoop)
      } else {
        //   console.log("bb")
          sortCompletionCallback(arr);
      }
    }
  
    // Kick the first outer loop off, starting `madeAnySwaps` as true.
    outerBubbleSortLoop(true)
  }
  
//   absurdBubbleSort([3, 2, 1], function(arr) {
//     console.log("Sorted array: " + JSON.stringify(arr));
//     reader.close();
//   });



// working version and test case
/*
let tooSoon = false;
Function.prototype.myThrottle = function (interval) {
          if(tooSoon===false){
            tooSoon = true;
            return () => {
              setTimeout(() => {
                  tooSoon = false;
                  this();
                }, interval);
            } 
        } else {
          return () => {return}}}
          */





// let tooSoon = false;
// Function.prototype.myThrottle = function (interval) {
//   if (tooSoon === false) {
//     tooSoon = true;
//     return () => {
//       setTimeout(() => {
//         tooSoon = false;
//         this();
//       }, interval);
//     }
//   } else {
//     return () => {console.log("do nothing")}
//   }
// }

// myMethod = function () { console.log("hello") };
// const interval = setInterval(() => {
//     myMethod.myThrottle(5000)();
// }, 1000);








class SearchBar {
    constructor() {
        this.query = "";

        this.type = this.type.bind(this);
        this.search = this.search.bind(this);
    }

    type(letter) {
        this.query += letter;
        this.search();
    }

    search() {
        console.log(`searching for ${this.query}`);
    }
}




Function.prototype.myDebounce = function(interval){
    let timeout;
    return ()=> { 
        clearTimeout(timeout)
        timeout = setTimeout(()=> {
            this();
            timeout = null;
        }, interval);
        }
}



const searchBar = new SearchBar();
searchBar.search = searchBar.search.myDebounce(100);

const queryForHelloWorld = () => {
    searchBar.type("h");
    searchBar.type("e");
    searchBar.type("l");
    searchBar.type("l");
    searchBar.type("o");
    searchBar.type(" ");
    searchBar.type("w");
    searchBar.type("o");
    searchBar.type("r");
    searchBar.type("l");
    searchBar.type("d");
};



// queryForHelloWorld();


function continuosAdd() {
  const args = [];
  return function _curriedAdd(num){
    args.push(num);
    console.log(args);
    console.log(args.reduce((acc, ele)=> {
      return acc + ele;
    }));
    // return _curriedAdd;
  }
}

// calculator = continuosAdd();  // first returned function (need an up)
// console.log(calculator);
// console.log(calculator(2))
// ; // second (inside returned function)

class Animal {
  constructor(name, color) {
    this.name = name;
    this.color = color;
  }
}

class Cat extends Animal {

  constructor(name, color){
    super(name, color);
  }
}

oreo = new Cat("oreo cookie", "black and whtie");
animal = new Animal
console.log(oreo.name);
console.log(oreo.color);
console.log(oreo.constructor); // class Cat extends Animal
console.log(oreo.prototype); // undefined
console.log(oreo.__proto__ === Cat.prototype); //true
console.log(oreo.constructor === Cat); //true
console.log(Animal.__proto__ === Object); //false
console.log(Cat.constructor) //function
console.log(Cat.prototype) //Animal object
console.log(Cat.__proto__ === Animal); // true
console.log(Animal.prototype.constructor) // {}
console.log(Cat.prototype.__proto__ == Animal.prototype) // true

// function Surrogate(){};
// Surrogate.prototype = Animal.prototype;
// Cat.prototype = new Surrogate();
// Cat.prototype.constructor = Cat; 