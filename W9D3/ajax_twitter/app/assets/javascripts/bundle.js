/******/ (() => { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "./frontend/api_util.js":
/*!******************************!*\
  !*** ./frontend/api_util.js ***!
  \******************************/
/***/ ((module) => {

const APIUtil = {
    followUser: id => {
       return  $.ajax({
            url: `/users/${id}/follow`,
            method: 'POST',
            dataType: 'json'
        })

    },

    unfollowerUser: id => {
       return $.ajax({
            url: `/users/${id}/follow`,
            method: 'DELETE',
            dataType: 'json'
        })
        
    }
}


module.exports = APIUtil;

/***/ }),

/***/ "./frontend/follow_toggle.js":
/*!***********************************!*\
  !*** ./frontend/follow_toggle.js ***!
  \***********************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

const APIUtil = __webpack_require__(/*! ./api_util.js */ "./frontend/api_util.js");


class FollowToggle{
    constructor(button){
        this.$button = $(button);
        this.userId = this.$button.data('user-id');
        this.followState = this.$button.data('initial-follow-state');
        this.render();
        this.handleClick = this.handleClick.bind(this);
        this.$button.click(this.handleClick);
    }

    render(){
        if (this.followState === "unfollowed") {this.$button.html('Follow!')};
        if (this.followState === "followed") {this.$button.html('Unfollowed!')};
    }

    handleClick(e){
        console.log("here");
        e.preventDefault();
        if (this.followState === "unfollowed"){
            APIUtil.followUser(this.userId).then(() => {
                this.followState = "followed";
                this.render();
            })
     
        // $.ajax({
        //     url: `/users/${this.userId}/follow`,
        //     method: 'POST',
        //     dataType: 'json',
        // }).then(()=> {
        //     this.followState = "followed";
        //     this.render();
        

        } else {

            APIUtil.unfollowerUser(this.userId).then(() => {
                this.followState = "unfollowed";
                this.render();
            })
        }
        


}
}



module.exports = FollowToggle;


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
var __webpack_exports__ = {};
// This entry need to be wrapped in an IIFE because it need to be isolated against other modules in the chunk.
(() => {
/*!*****************************!*\
  !*** ./frontend/twitter.js ***!
  \*****************************/
const FollowToggle = __webpack_require__(/*! ./follow_toggle.js */ "./frontend/follow_toggle.js");

$(() => {  

    $("button.follow-toggle").each(function (i,b) {
        return new FollowToggle(b);
    });
});


})();

/******/ })()
;
//# sourceMappingURL=bundle.js.map