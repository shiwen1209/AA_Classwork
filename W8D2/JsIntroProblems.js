function madLib(verb, adj, noun) {
    console.log("We shall " + verb.toUpperCase() + " the " + adj.toUpperCase() + " " + noun.toUpperCase() + ".");
}
// madLib('make', 'best', 'guac');

// only smi column after } when initializing a variable

function isSubstring(str, substring) {
        console.log(str.includes(substring))
}

// isSubstring("time to program", "time")
// isSubstring("Jump for joy", "joys")

function fizzBuzz(arr) {
    let newArr = []
    arr.forEach(element => {
        if (element % 3 === 0 ^ element % 5 === 0) {
            newArr.push(element)
        }
    });
    console.log(newArr);
}

// fizzBuzz([1,2,3,4,5,6,6,9,10, 15, 45]);

// flasy value : null, undefined, NaN, 0 /-0, '', 

function isPrime(num) {
    if(num < 2) {
        return false
    } else {
        for (let i = 2; i < num; i++) {
            if(num % i === 0){return false}
        }
    }
    return true
}

// console.log(isPrime(8));
// console.log(isPrime(2));
// console.log(isPrime(3));
// console.log(isPrime(1));
// console.log(isPrime(-1));

function sumOfNPrimes(n) {
    let sum = 0; 
    let i = 0;
    while(n>0) {
        if(isPrime(i)){
            sum += i;
            n -= 1;
        }
        i += 1;
    }
    return sum;
}

// console.log(sumOfNPrimes(5))
