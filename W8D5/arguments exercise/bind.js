Function.prototype.myBind = function(context) {
    let that = this 
    let args =  Array.from(arguments);
    return function(){
        args2 = args.concat(Array.from(arguments));
        that.apply(args2[0],args2.slice(1));
    }
}


Function.prototype.myBind2 = function(context,...args) {
    return (...args2) => {
        this.apply(context, args.concat(args2));
    }
}


class Cat {
    constructor(name) {
      this.name = name;
    }
  
    says(sound, person) {
      console.log(`${this.name} says ${sound} to ${person}!`);
      return true;
    }
  }
  
  class Dog {
    constructor(name) {
      this.name = name;
    }
  }
  
  const markov = new Cat("Markov");
  const pavlov = new Dog("Pavlov");
  
  markov.says("meow", "Ned");
  // Markov says meow to Ned!
  // true
  
  // bind time args are "meow" and "Kush", no call time args
  markov.says.myBind(pavlov, "meow", "Kush")();
  // Pavlov says meow to Kush!
  // true
  
  // no bind time args (other than context), call time args are "meow" and "a tree"
  markov.says.myBind(pavlov)("meow", "a tree");
  // Pavlov says meow to a tree!
  // true
  
  // bind time arg is "meow", call time arg is "Markov"
  markov.says.myBind(pavlov, "meow")("Markov");
  // Pavlov says meow to Markov!
  // true
  
  // // no bind time args (other than context), call time args are "meow" and "me"
  // const notMarkovSays = markov.says.myBind2(pavlov);
  // notMarkovSays("meow", "me");
  // // Pavlov says meow to me!
  // // true

  // markov.says.myBind2(pavlov, "meow", "Kush")();
  // // Pavlov says meow to Kush!
  // // true
  
  // // no bind time args (other than context), call time args are "meow" and "a tree"
  // markov.says.myBind2(pavlov)("meow", "a tree");
  // // Pavlov says meow to a tree!
  // // true
  
  // // bind time arg is "meow", call time arg is "Markov"
  // markov.says.myBind2(pavlov, "meow")("Markov");
  // // Pavlov says meow to Markov!
  // // true
  
  // // no bind time args (other than context), call time args are "meow" and "me"
  // const notMarkovSays = markov.says.myBind2(pavlov);
  // notMarkovSays2("meow", "me");
  // // Pavlov says meow to me!
  // // true
