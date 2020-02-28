import consumer from "./consumer"

consumer.subscriptions.create("TweetChannel", {
  connected() {
  	console.log("Tweet all the way bro")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data);
    var current_signed_in_user = $("#current_signed_in_user").val()//1, followers = data.followers.split(" ")
    if(data.followers.length && (data.followers.includes(current_signed_in_user) || current_signed_in_user == data.tweet_owner)){
      console.log("You have the privilege")
      var tweet =

            `<div class="tweet-container">
              <a href="#top-bar1" class="tweet-link"> </a>
              <div class="sides">
                  <div class="side-left-side">
                      <a href="#profile">
                          <div class="profile-img"></div>
                      </a>
                  </div>

                  <div class="right">
                      <div class="top-header">
                          <span class="username"><a href="/${data.user.username}">${data.user.name}</a></span>
                          <span class="handle">@${data.user.username}</span>
                          <div class="dot"></div>
                          <span class="time_ago">${data.time_sent}</span>
                      </div>

                      <div class="tweet-text">
                          ${data.content.tweet}
                      </div>

                      <div class="tweet-images">
                          <div class="single-image"></div>
                      </div>

                      <div class="tweet-icons">
                          <span class="icons">
                              <i class="fa fa-comment"></i>1
                          </span>
                          <span class="icons">
                              <i class="fa fa-retweet"></i>2
                          </span>
                          <span class="icons">
                              <i class="fa fa-heart"></i>3
                          </span>
                          <span class="icons">
                              <i class="fa fa-arrow-up"></i>4
                          </span>
                      </div>
                  </div>
              </div>
          </div>`;
          console.log(tweet);
          $(".all-tweets").prepend(tweet);
      // $("ul#tweets").prepend("<li>" + data.content + "</li>")
    }
    // Called when there's incoming data on the websocket for this channel
  }
});
