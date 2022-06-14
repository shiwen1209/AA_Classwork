/*
 * ATTENTION: The "eval" devtool has been used (maybe by default in mode: "development").
 * This devtool is neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
/******/ (() => { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "./dist/keymaster.js":
/*!***************************!*\
  !*** ./dist/keymaster.js ***!
  \***************************/
/***/ (function(module) {

eval("//     keymaster.js\n//     (c) 2011-2013 Thomas Fuchs\n//     keymaster.js may be freely distributed under the MIT license.\n\n;(function(global){\n  var k,\n    _handlers = {},\n    _mods = { 16: false, 18: false, 17: false, 91: false },\n    _scope = 'all',\n    // modifier keys\n    _MODIFIERS = {\n      '⇧': 16, shift: 16,\n      '⌥': 18, alt: 18, option: 18,\n      '⌃': 17, ctrl: 17, control: 17,\n      '⌘': 91, command: 91\n    },\n    // special keys\n    _MAP = {\n      backspace: 8, tab: 9, clear: 12,\n      enter: 13, 'return': 13,\n      esc: 27, escape: 27, space: 32,\n      left: 37, up: 38,\n      right: 39, down: 40,\n      del: 46, 'delete': 46,\n      home: 36, end: 35,\n      pageup: 33, pagedown: 34,\n      ',': 188, '.': 190, '/': 191,\n      '`': 192, '-': 189, '=': 187,\n      ';': 186, '\\'': 222,\n      '[': 219, ']': 221, '\\\\': 220\n    },\n    code = function(x){\n      return _MAP[x] || x.toUpperCase().charCodeAt(0);\n    },\n    _downKeys = [];\n\n  for(k=1;k<20;k++) _MAP['f'+k] = 111+k;\n\n  // IE doesn't support Array#indexOf, so have a simple replacement\n  function index(array, item){\n    var i = array.length;\n    while(i--) if(array[i]===item) return i;\n    return -1;\n  }\n\n  // for comparing mods before unassignment\n  function compareArray(a1, a2) {\n    if (a1.length != a2.length) return false;\n    for (var i = 0; i < a1.length; i++) {\n        if (a1[i] !== a2[i]) return false;\n    }\n    return true;\n  }\n\n  var modifierMap = {\n      16:'shiftKey',\n      18:'altKey',\n      17:'ctrlKey',\n      91:'metaKey'\n  };\n  function updateModifierKey(event) {\n      for(k in _mods) _mods[k] = event[modifierMap[k]];\n  };\n\n  // handle keydown event\n  function dispatch(event) {\n    var key, handler, k, i, modifiersMatch, scope;\n    key = event.keyCode;\n\n    if (index(_downKeys, key) == -1) {\n        _downKeys.push(key);\n    }\n\n    // if a modifier key, set the key.<modifierkeyname> property to true and return\n    if(key == 93 || key == 224) key = 91; // right command on webkit, command on Gecko\n    if(key in _mods) {\n      _mods[key] = true;\n      // 'assignKey' from inside this closure is exported to window.key\n      for(k in _MODIFIERS) if(_MODIFIERS[k] == key) assignKey[k] = true;\n      return;\n    }\n    updateModifierKey(event);\n\n    // see if we need to ignore the keypress (filter() can can be overridden)\n    // by default ignore key presses if a select, textarea, or input is focused\n    if(!assignKey.filter.call(this, event)) return;\n\n    // abort if no potentially matching shortcuts found\n    if (!(key in _handlers)) return;\n\n    scope = getScope();\n\n    // for each potential shortcut\n    for (i = 0; i < _handlers[key].length; i++) {\n      handler = _handlers[key][i];\n\n      // see if it's in the current scope\n      if(handler.scope == scope || handler.scope == 'all'){\n        // check if modifiers match if any\n        modifiersMatch = handler.mods.length > 0;\n        for(k in _mods)\n          if((!_mods[k] && index(handler.mods, +k) > -1) ||\n            (_mods[k] && index(handler.mods, +k) == -1)) modifiersMatch = false;\n        // call the handler and stop the event if neccessary\n        if((handler.mods.length == 0 && !_mods[16] && !_mods[18] && !_mods[17] && !_mods[91]) || modifiersMatch){\n          if(handler.method(event, handler)===false){\n            if(event.preventDefault) event.preventDefault();\n              else event.returnValue = false;\n            if(event.stopPropagation) event.stopPropagation();\n            if(event.cancelBubble) event.cancelBubble = true;\n          }\n        }\n      }\n    }\n  };\n\n  // unset modifier keys on keyup\n  function clearModifier(event){\n    var key = event.keyCode, k,\n        i = index(_downKeys, key);\n\n    // remove key from _downKeys\n    if (i >= 0) {\n        _downKeys.splice(i, 1);\n    }\n\n    if(key == 93 || key == 224) key = 91;\n    if(key in _mods) {\n      _mods[key] = false;\n      for(k in _MODIFIERS) if(_MODIFIERS[k] == key) assignKey[k] = false;\n    }\n  };\n\n  function resetModifiers() {\n    for(k in _mods) _mods[k] = false;\n    for(k in _MODIFIERS) assignKey[k] = false;\n  };\n\n  // parse and assign shortcut\n  function assignKey(key, scope, method){\n    var keys, mods;\n    keys = getKeys(key);\n    if (method === undefined) {\n      method = scope;\n      scope = 'all';\n    }\n\n    // for each shortcut\n    for (var i = 0; i < keys.length; i++) {\n      // set modifier keys if any\n      mods = [];\n      key = keys[i].split('+');\n      if (key.length > 1){\n        mods = getMods(key);\n        key = [key[key.length-1]];\n      }\n      // convert to keycode and...\n      key = key[0]\n      key = code(key);\n      // ...store handler\n      if (!(key in _handlers)) _handlers[key] = [];\n      _handlers[key].push({ shortcut: keys[i], scope: scope, method: method, key: keys[i], mods: mods });\n    }\n  };\n\n  // unbind all handlers for given key in current scope\n  function unbindKey(key, scope) {\n    var multipleKeys, keys,\n      mods = [],\n      i, j, obj;\n\n    multipleKeys = getKeys(key);\n\n    for (j = 0; j < multipleKeys.length; j++) {\n      keys = multipleKeys[j].split('+');\n\n      if (keys.length > 1) {\n        mods = getMods(keys);\n      }\n\n      key = keys[keys.length - 1];\n      key = code(key);\n\n      if (scope === undefined) {\n        scope = getScope();\n      }\n      if (!_handlers[key]) {\n        return;\n      }\n      for (i = 0; i < _handlers[key].length; i++) {\n        obj = _handlers[key][i];\n        // only clear handlers if correct scope and mods match\n        if (obj.scope === scope && compareArray(obj.mods, mods)) {\n          _handlers[key][i] = {};\n        }\n      }\n    }\n  };\n\n  // Returns true if the key with code 'keyCode' is currently down\n  // Converts strings into key codes.\n  function isPressed(keyCode) {\n      if (typeof(keyCode)=='string') {\n        keyCode = code(keyCode);\n      }\n      return index(_downKeys, keyCode) != -1;\n  }\n\n  function getPressedKeyCodes() {\n      return _downKeys.slice(0);\n  }\n\n  function filter(event){\n    var tagName = (event.target || event.srcElement).tagName;\n    // ignore keypressed in any elements that support keyboard data input\n    return !(tagName == 'INPUT' || tagName == 'SELECT' || tagName == 'TEXTAREA');\n  }\n\n  // initialize key.<modifier> to false\n  for(k in _MODIFIERS) assignKey[k] = false;\n\n  // set current scope (default 'all')\n  function setScope(scope){ _scope = scope || 'all' };\n  function getScope(){ return _scope || 'all' };\n\n  // delete all handlers for a given scope\n  function deleteScope(scope){\n    var key, handlers, i;\n\n    for (key in _handlers) {\n      handlers = _handlers[key];\n      for (i = 0; i < handlers.length; ) {\n        if (handlers[i].scope === scope) handlers.splice(i, 1);\n        else i++;\n      }\n    }\n  };\n\n  // abstract key logic for assign and unassign\n  function getKeys(key) {\n    var keys;\n    key = key.replace(/\\s/g, '');\n    keys = key.split(',');\n    if ((keys[keys.length - 1]) == '') {\n      keys[keys.length - 2] += ',';\n    }\n    return keys;\n  }\n\n  // abstract mods logic for assign and unassign\n  function getMods(key) {\n    var mods = key.slice(0, key.length - 1);\n    for (var mi = 0; mi < mods.length; mi++)\n    mods[mi] = _MODIFIERS[mods[mi]];\n    return mods;\n  }\n\n  // cross-browser events\n  function addEvent(object, event, method) {\n    if (object.addEventListener)\n      object.addEventListener(event, method, false);\n    else if(object.attachEvent)\n      object.attachEvent('on'+event, function(){ method(window.event) });\n  };\n\n  // set the handlers globally on document\n  addEvent(document, 'keydown', function(event) { dispatch(event) }); // Passing _scope to a callback to ensure it remains the same by execution. Fixes #48\n  addEvent(document, 'keyup', clearModifier);\n\n  // reset modifiers to false whenever the window is (re)focused.\n  addEvent(window, 'focus', resetModifiers);\n\n  // store previously defined key\n  var previousKey = global.key;\n\n  // restore previously defined key and return reference to our key object\n  function noConflict() {\n    var k = global.key;\n    global.key = previousKey;\n    return k;\n  }\n\n  // set window.key and window.key.set/get/deleteScope, and the default filter\n  global.key = assignKey;\n  global.key.setScope = setScope;\n  global.key.getScope = getScope;\n  global.key.deleteScope = deleteScope;\n  global.key.filter = filter;\n  global.key.isPressed = isPressed;\n  global.key.getPressedKeyCodes = getPressedKeyCodes;\n  global.key.noConflict = noConflict;\n  global.key.unbind = unbindKey;\n\n  if(true) module.exports = assignKey;\n\n})(this);\n\n\n//# sourceURL=webpack:///./dist/keymaster.js?");

/***/ }),

/***/ "./src/asteroid.js":
/*!*************************!*\
  !*** ./src/asteroid.js ***!
  \*************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const MovingObject = __webpack_require__(/*! ./moving_object.js */ \"./src/moving_object.js\");\nconst Util = __webpack_require__(/*! ./utils.js */ \"./src/utils.js\");\n\n\nfunction Asteroid(pos) {\n  Asteroid.COLOR = \"#2803fc\";\n  Asteroid.RADIUS = 20;\n    MovingObject.call(this, {\n        pos: pos,\n        vel: [(Math.random() * 5) + 5, (Math.random() * 5) + 5],\n        color: Asteroid.COLOR,\n        radius: Asteroid.RADIUS\n    })\n   \n\n}\n\nAsteroid.prototype.collidedWith = function(otherObject){\n    console.log(\"colided\")\n    if (otherObject.constructor === Ship && this.isCollidedWith(otherObject)){\n        otherObject.relocate();\n    }\n\n}\n\nUtil.inherits(Asteroid, MovingObject);\n\n\nmodule.exports = Asteroid;\n\n\n//# sourceURL=webpack:///./src/asteroid.js?");

/***/ }),

/***/ "./src/bullet.js":
/*!***********************!*\
  !*** ./src/bullet.js ***!
  \***********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const MovingObject = __webpack_require__(/*! ./moving_object.js */ \"./src/moving_object.js\");\nconst Util = __webpack_require__(/*! ./utils.js */ \"./src/utils.js\");\n\nfunction Bullet(pos, vel) {\n  Bullet.COLOR = \"#505050\";\n  Bullet.RADIUS = 2;\n  MovingObject.call(this, {\n      pos: pos, \n      vel: [vel[0]*10, vel[1]*10],\n      color: Bullet.COLOR,\n      radius: Bullet.RADIUS\n    })\n  this.isWrappable = false;\n}\n\nUtil.inherits(Bullet, MovingObject);\n\nmodule.exports = Bullet;\n\n\n//# sourceURL=webpack:///./src/bullet.js?");

/***/ }),

/***/ "./src/game.js":
/*!*********************!*\
  !*** ./src/game.js ***!
  \*********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const moving_object = __webpack_require__(/*! ./moving_object */ \"./src/moving_object.js\")\nconst Asteroid = __webpack_require__(/*! ./asteroid */ \"./src/asteroid.js\")\nconst Ship = __webpack_require__(/*! ./ship */ \"./src/ship.js\")\nconst Bullet = __webpack_require__(/*! ./bullet.js */ \"./src/bullet.js\");\n\nfunction Game(){\n  Game.DIM_X = 640;\n  Game.DIM_Y = 480;\n  Game.NUM_ASTEROIDS = 20;\n  this.asteroidArr = this.add_asteroids();\n  this.ship = new Ship();\n  this.bullets = []\n  this.allObjects = this.asteroidArr.concat([this.ship]).concat(this.bullets);\n}\n\nGame.prototype.add_asteroids = function(){\n    let asteroidsArr = []\n    while (asteroidsArr.length < Game.NUM_ASTEROIDS) {\n    let a = new Asteroid ([Math.random()*Game.DIM_X,Math.random()*Game.DIM_Y]);\n    a.id = asteroidsArr.length\n    asteroidsArr.push(a);\n    }\n    return asteroidsArr;\n}\n\nGame.prototype.add = function(obj) {\n  if (obj.constructor === Bullet){\n    this.bullets.push(obj);\n  } else if (obj.constructor === Asteroid){\n      this.asteroidArr.push(obj);\n  }\n}\n\nGame.prototype.draw = function(ctx){\n  ctx.clearRect(0,0,Game.DIM_X, Game.DIM_Y)\n  this.allObjects = this.asteroidArr.concat([this.ship]).concat(this.bullets);\n  this.allObjects.forEach(function (el) { el.draw(ctx)})\n\n}\n\nGame.prototype.move = function(){\n  this.allObjects.forEach(function(el) {el.move()})\n  let that = this;\n  this.allObjects.forEach(function(el) {\n    if(el.isWrappable){\n    that.wrap(el.pos)\n    } else if (that.isOutOfBounds(el.pos))\n    { that.remove(el)}\n  } )\n}\n\nGame.prototype.wrap = function(pos){\n  if (pos[0] > Game.DIM_X) {pos[0] = pos[0] % Game.DIM_X}\n  if (pos[1] > Game.DIM_Y) {pos[1] = pos[1] % Game.DIM_Y}\n  if (pos[0] < 0) { pos[0] = (pos[0] + Game.DIM_X) }\n  if (pos[1] < 0) { pos[1] = (pos[1] + Game.DIM_Y) }\n\n}\n\nGame.prototype.step = function (){\n  this.move();\n  this.checkCollisions();\n}\n\n\nGame.prototype.remove = function (obj){\nif (obj.constructor === Asteroid){\n  this.asteroidArr = this.asteroidArr.filter(function(item){return item !== obj;})\n  } else if (obj.constructor === Bullet){\n  this.bullets = this.bullets.filter(function(item){ return item !== obj; })\n  }\n}\n\nGame.prototype.checkCollisions = function(){\n    for(let i =0; i< this.asteroidArr.length; i++){\n          \n      if(this.asteroidArr[i].isCollidedWith(this.ship)){ \n                this.ship.reloc();\n        }\n    \n      for(let j = 0; j < this.bullets.length; j++){\n        if (this.asteroidArr[i].isCollidedWith(this.bullets[j])) {\n          this.remove(this.bullets[j]);\n          this.remove(this.asteroidArr[i]);\n          break;\n        }}\n        }\n    }\n\nGame.prototype.isOutOfBounds = function(pos){\n  if (pos[0] > Game.DIM_X || pos[0] < 0 || \n    pos[1] > Game.DIM_Y || pos[1] < 0){\n      return true;\n    }\n  return false;\n}\n\n\n\nmodule.exports = Game;\n\n\n//# sourceURL=webpack:///./src/game.js?");

/***/ }),

/***/ "./src/game_view.js":
/*!**************************!*\
  !*** ./src/game_view.js ***!
  \**************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const Game = __webpack_require__(/*! ./game */ \"./src/game.js\")\nconst Keymaster = __webpack_require__(/*! ../dist/keymaster */ \"./dist/keymaster.js\");\nconst Bullet = __webpack_require__(/*! ./bullet */ \"./src/bullet.js\")\n\nfunction GameView(ctx){\n  \n  GameView.MOVES = {\n      \"w\": [0, -1],\n      \"a\": [-1, 0],\n      \"s\": [0, 1],\n      \"d\": [1, 0],\n  };\n\n    this.game = new Game();\n    this.ctx = ctx;\n}\n\n\nGameView.prototype.start = function(){\n\n\nlet that = this;\n\nsetInterval(function () {\n    that.game.step();\n    that.game.draw(that.ctx);\n    }, 50)\n\nthis.bindKeyHandlers()\n  \n}\n\nGameView.prototype.bindKeyHandlers = function(){\n\n\n    const ship = this.game.ship;\n    Object.keys(GameView.MOVES).forEach(function (k) {\n        const move = GameView.MOVES[k];\n        key(k, function () { ship.power(move); });\n    });\n    key(\"space\",  () => { \n        if (ship.fireBullet()){\n        this.game.add(ship.fireBullet()) \n        }\n    });\n\n\n}\n\nmodule.exports = GameView;\n\n\n//# sourceURL=webpack:///./src/game_view.js?");

/***/ }),

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/***/ ((__unused_webpack_module, __unused_webpack_exports, __webpack_require__) => {

eval("const MovingObject = __webpack_require__(/*! ./moving_object.js */ \"./src/moving_object.js\");\nwindow.MovingObject = MovingObject;\n\nconst Asteroid = __webpack_require__(/*! ./asteroid.js */ \"./src/asteroid.js\");\nwindow.Asteroid = Asteroid;\n\nconst Game = __webpack_require__(/*! ./game.js */ \"./src/game.js\");\nwindow.Game = Game;\n\nconst GameView = __webpack_require__(/*! ./game_view.js */ \"./src/game_view.js\");\nwindow.GameView = GameView;\n\nwindow.addEventListener('DOMContentLoaded', (event) => {\n    canvas = document.getElementById('game-canvas')\n    canvas.getContext('2d');\n  const game = new GameView(canvas.getContext(\"2d\"));\n    window.game = game;\n    window.allobjects = game.allobjects\n  window.ship = game.ship\n    game.start();\n\n});\n\n\n\n\n\n//# sourceURL=webpack:///./src/index.js?");

/***/ }),

/***/ "./src/moving_object.js":
/*!******************************!*\
  !*** ./src/moving_object.js ***!
  \******************************/
/***/ ((module) => {

eval("// const Game = require(\"./game\")\n\nfunction MovingObject (object){\n    this.object = object;\n    this.pos = object.pos;\n    this.vel = object.vel;\n    this.radius = object.radius;\n    this.color = object.color;\n    this.isWrappable = true;\n}\n\n\nMovingObject.prototype.draw = function(ctx){\n  \nctx.beginPath();\nctx.fillStyle = this.color;\nctx.arc(this.pos[0], this.pos[1], this.radius, 0, 2*Math.PI)\nctx.fill()\n\n}\n\nMovingObject.prototype.move = function (){\n  this.pos[0] += this.vel[0]\n  this.pos[1] += this.vel[1]\n}\n\n\nMovingObject.prototype.isCollidedWith = function (other) {\n  let dist = Math.sqrt((this.pos[0] - other.pos[0]) ** 2 + (this.pos[1] - other.pos[1]) ** 2)\n  if (dist < (this.radius + other.radius)) {return true;} \n  return false;\n}\n\nMovingObject.prototype.collidedWith = function (otherObject) {}\n\n\n\nmodule.exports = MovingObject;\n\n\n//# sourceURL=webpack:///./src/moving_object.js?");

/***/ }),

/***/ "./src/ship.js":
/*!*********************!*\
  !*** ./src/ship.js ***!
  \*********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const MovingObject = __webpack_require__(/*! ./moving_object.js */ \"./src/moving_object.js\");\nconst Util = __webpack_require__(/*! ./utils.js */ \"./src/utils.js\");\nconst Bullet = __webpack_require__(/*! ./bullet.js */ \"./src/bullet.js\");\n\n\nfunction Ship() {\n  Ship.COLOR = \"#ff0000\";\n  Ship.RADIUS = 15;\n  MovingObject.call(this, {\n    pos: [Math.random() * 635, Math.random() * 475],\n    vel: [0,0],\n    color: Ship.COLOR,\n    radius: Ship.RADIUS \n  })\n}\n\nUtil.inherits(Ship, MovingObject);\n\nShip.prototype.reloc = function(){\n  this.pos = [Math.random() * 640, Math.random() * 640];\n  this.vel = [0,0];\n}\n\nShip.prototype.power = function (impulse){\n    this.vel[1] = impulse[1]\n    this.vel[0] = impulse[0]\n}\n\nShip.prototype.fireBullet = function (){\n  if (this.vel[0] !=0 || this.vel[1] !=0){\n  let pos = [this.pos[0], this.pos[1]];\n  let vel = [this.vel[0], this.vel[1]];\n  let bullet = new Bullet(pos, vel);\n   return bullet;\n  } else {return false}\n}\n\nmodule.exports = Ship;\n\n\n//# sourceURL=webpack:///./src/ship.js?");

/***/ }),

/***/ "./src/utils.js":
/*!**********************!*\
  !*** ./src/utils.js ***!
  \**********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const MovingObject = __webpack_require__(/*! ./moving_object */ \"./src/moving_object.js\");\n\nconst Util = {\n   inherits(childClass, parentClass) {\n        function Surrogate(){}\n        Surrogate.prototype = parentClass.prototype;\n        childClass.prototype = new Surrogate;\n        childClass.prototype.constructor = childClass;\n    }\n};\n\nmodule.exports = Util;\n\n//# sourceURL=webpack:///./src/utils.js?");

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module can't be inlined because the eval devtool is used.
/******/ 	var __webpack_exports__ = __webpack_require__("./src/index.js");
/******/ 	
/******/ })()
;