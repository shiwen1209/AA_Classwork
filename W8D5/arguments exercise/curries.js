function curriedSum(numArgs){
    const numbers = [];

    return function _curriedSum(num)
    {
        numbers.push(num)
        if (numbers.length === numArgs)
        {
            return numbers.reduce(
                (previousValue, currentValue) => previousValue + currentValue
            );
        }
        return _curriedSum;
    }
}

const sum = curriedSum(4);
console.log(sum(5)(30)(20)(1));


Function.prototype.curry = function(numArgs) {
    let args = [];
    let that = this;
    return function _function(arg){
        args.push(arg)
        numArgs -= 1;
        if (numArgs > 0) 
        {
            return _function;
        } else 
        {
            return that(...args);
        }
    }
}

function sumThree(num1, num2, num3) {
    return num1 + num2 + num3;
  }
  
  console.log(sumThree(4, 20, 6)); // == 30
  
  // you'll write `Function#curry`!
  let f1 = sumThree.curry(3); // tells `f1` to wait until 3 arguments are given before running `sumThree`
  f1 = f1(4); // [Function]
  f1 = f1(20); // [Function]
  f1 = f1(6); // = 30
  
  // or more briefly:
  console.log(sumThree.curry(3)(4)(20)(6)); // == 30