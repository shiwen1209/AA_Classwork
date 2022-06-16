/*
 * ATTENTION: The "eval" devtool has been used (maybe by default in mode: "development").
 * This devtool is neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ "./src/bird.js":
/*!*********************!*\
  !*** ./src/bird.js ***!
  \*********************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   \"default\": () => (/* binding */ Bird)\n/* harmony export */ });\nconst CONSTANTS = {\n    GRAVITY:  0.5,\n    FLAP_SPEED:  -8,\n    TERMINAL_VEL:  12,\n    BIRD_WIDTH:  40,\n    BIRD_HEIGHT:  30\n  };\n\nclass Bird{\n    constructor(dimensions){\n        this.velocity = 0;\n        this.dimensions = dimensions;\n        this.x_pos = dimensions.width / 3;\n        this.y_pos = dimensions.height / 2;\n    }\n\n    //this.dimensions.width, this.dimensions.height\n\n    drawBird(ctx){\n\n        ctx.fillStyle = \"yellow\";\n        ctx.fillRect(this.x_pos, this.y_pos, CONSTANTS.BIRD_WIDTH, CONSTANTS.BIRD_HEIGHT); \n\n    }\n\n    animate(ctx){\n        this.move();\n        this.drawBird(ctx);\n    }\n\n    move(){\n        this.y_pos += this.velocity;\n        this.velocity += CONSTANTS.GRAVITY;\n    }\n\n    flap(){\n        this.velocity = CONSTANTS.FLAP_SPEED;\n    }\n\n    getBounds(){\n        return [[this.x_pos, this.y_pos], [this.x_pos+CONSTANTS.BIRD_WIDTH, this.y_pos + CONSTANTS.BIRD_HEIGHT]];\n    }\n\n    outBounds(){\n        return (this.y_pos < 0 || this.y_pos + 30 > 640)\n    }\n\n\n\n}\n\n\n//# sourceURL=webpack:///./src/bird.js?");

/***/ }),

/***/ "./src/game.js":
/*!*********************!*\
  !*** ./src/game.js ***!
  \*********************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   \"default\": () => (/* binding */ FlappyBird)\n/* harmony export */ });\n/* harmony import */ var _level__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./level */ \"./src/level.js\");\n/* harmony import */ var _bird__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./bird */ \"./src/bird.js\");\n\n\n\nclass FlappyBird {\n  constructor(canvas){\n    this.ctx = canvas.getContext(\"2d\");\n    this.dimensions = { width: canvas.width, height: canvas.height };\n    this.registerEvents();\n    this.restart();\n    this.score = 0;\n  }\n\n  animate(){\n    this.level.animate(this.ctx);\n    this.bird.animate(this.ctx);\n    \n    if(this.level.collidesWith(this.bird.getBounds()) || this.bird.outBounds())\n    {\n      this.gameOver();\n    }\n    if(this.running)\n    {\n    requestAnimationFrame(this.animate.bind(this));\n    }\n  }\n\n  restart(){\n    this.running = false;\n    this.level = new _level__WEBPACK_IMPORTED_MODULE_0__[\"default\"](this.dimensions);\n    this.bird = new _bird__WEBPACK_IMPORTED_MODULE_1__[\"default\"](this.dimensions);\n    this.animate();\n  }\n\n  play(){\n    this.running = true;\n    this.animate();\n  }\n\n  click(){\n    if(!this.running){\n      this.play();\n    }\n    this.bird.flap();\n    \n  }\n\n  registerEvents() {\n    this.boundClickHandler = this.click.bind(this);\n    this.ctx.canvas.addEventListener(\"mousedown\", this.boundClickHandler);\n  }\n\n  gameOver(){\n    alert(\"game over!\");\n    this.restart();\n  }\n\n \n  \n\n\n\n}\n\n\n//# sourceURL=webpack:///./src/game.js?");

/***/ }),

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _game__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./game */ \"./src/game.js\");\n\n\nconst canvas = document.getElementById('bird-game');\nnew _game__WEBPACK_IMPORTED_MODULE_0__[\"default\"](canvas);\n\n//# sourceURL=webpack:///./src/index.js?");

/***/ }),

/***/ "./src/level.js":
/*!**********************!*\
  !*** ./src/level.js ***!
  \**********************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   \"default\": () => (/* binding */ Level)\n/* harmony export */ });\nclass Level {\n  constructor(dimensions) {\n    this.dimensions = dimensions;\n    let pipe1 = [800, 200];\n    let pipe2 = [1020, 350];\n    let pipe3 = [1240, 300];\n    this.pipes = [pipe1, pipe2, pipe3]\n\n  }\n\n  drawBackground(ctx) {\n    ctx.fillStyle = \"skyblue\";\n    ctx.fillRect(0, 0, this.dimensions.width, this.dimensions.height);\n  }\n  ///\n  animate(ctx)\n  {\n    this.drawBackground(ctx);\n    this.movePipes(3);\n    this.drawPipes(ctx);\n  }\n\n  movePipes(amt){\n    this.pipes.forEach((p, i)=> {\n      this.pipes[i][0] -= amt;\n    })\n\n    for(let i = 0; i<this.pipes.length; i++)\n    {\n      if (this.pipes[0][i] <= -40)\n      {\n        this.pipes.shift();\n        let x = this.pipes[this.pipes.length -1][0] + 220;\n        let y = this.getRandomY(200, 390);\n        this.pipes.push([x, y]);\n        break;\n      }\n    }\n\n    \n    \n  }\n\n  drawPipes(ctx){\n    this.pipes.forEach((p)=>{\n      ctx.fillStyle = \"green\";\n      ctx.fillRect(p[0], 0, 40, p[1]); \n\n      ctx.fillStyle = \"green\";\n      ctx.fillRect(p[0], p[1] + 150, 40, 640-p[1]-150); \n    })\n\n  }\n\n  getRandomY(min, max) {\n  return Math.random() * (max - min) + min;\n}\n\n  collidesWith(birdbounds) {\n    for(let i = 0; i < this.pipes.length; i++){\n      if( (birdbounds[0][0] < this.pipes[i][0] + 40 && birdbounds[0][0] > this.pipes[i][0]) || (birdbounds[1][0] < this.pipes[i][0] + 40 && birdbounds[1][0] > this.pipes[i][0])){\n        if(\n          birdbounds[1][1] >= this.pipes[i][1] + 150 ||\n          birdbounds[0][1] <= this.pipes[i][1]\n        ){return true; }\n    }\n    return false;\n  }\n  }\n\n\n\n}\n\n\n\n//# sourceURL=webpack:///./src/level.js?");

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
/******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	/* webpack/runtime/define property getters */
/******/ 	(() => {
/******/ 		// define getter functions for harmony exports
/******/ 		__webpack_require__.d = (exports, definition) => {
/******/ 			for(var key in definition) {
/******/ 				if(__webpack_require__.o(definition, key) && !__webpack_require__.o(exports, key)) {
/******/ 					Object.defineProperty(exports, key, { enumerable: true, get: definition[key] });
/******/ 				}
/******/ 			}
/******/ 		};
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/hasOwnProperty shorthand */
/******/ 	(() => {
/******/ 		__webpack_require__.o = (obj, prop) => (Object.prototype.hasOwnProperty.call(obj, prop))
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/make namespace object */
/******/ 	(() => {
/******/ 		// define __esModule on exports
/******/ 		__webpack_require__.r = (exports) => {
/******/ 			if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 				Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 			}
/******/ 			Object.defineProperty(exports, '__esModule', { value: true });
/******/ 		};
/******/ 	})();
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