const FollowToggle = require("./follow_toggle.js");

$(() => {  

    $("button.follow-toggle").each(function (i,b) {
        return new FollowToggle(b);
    });
});

