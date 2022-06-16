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