Function.prototype.inherits1 = function(parent){
    function Surrogate(){};
    Surrogate.prototype = parent.prototype;
    this.prototype = new Surrogate();
    this.prototype.constructor = this; 
}

Function.prototype.inherits2 = function(parent){
    this.prototype = Object.create(parent.prototype);
    this.prototype.constructor = this;
}


function Dog (name) {
    this.name = name;
  }
  
Dog.prototype.bark = function () {
    console.log(this.name + " barks!");
};

function Corgi (name) {
    Dog.call(this, name);
}

Corgi.inherits1(Dog);

Corgi.prototype.waddle = function () {
    console.log(this.name + " waddles!");
};

const blixa = new Corgi("Blixa");
blixa.bark();
blixa.waddle();
  