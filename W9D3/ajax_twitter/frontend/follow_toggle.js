const APIUtil = require("./api_util.js");


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
