function sum1() 
{
    let sum = 0;
    Array.from(arguments).forEach((ele) =>{
        sum += ele;
    })
    return sum;
}

function sum2(...args) 
{
    let sum = 0;
    args.forEach((ele) =>{
        sum += ele;
    })
    return sum;
}


// console.log(sum1(1, 2, 3, 4) === 10);
// console.log(sum1(1, 2, 3, 4, 5) === 15);

console.log(sum2(1, 2, 3, 4) === 10);
console.log(sum2(1, 2, 3, 4, 5) === 15);