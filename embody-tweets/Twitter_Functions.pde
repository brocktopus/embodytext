void connectTwitter() {

/*
When you initially connect to Twitter, you'll need the proper
credentials. In order to get them, you'll have to register your
application through dev.twitter.com -- it's a pretty painless
process but it's important to know if you've never had to before.
*/
 ConfigurationBuilder cb = new ConfigurationBuilder();
 cb.setOAuthConsumerKey("your consumer key goes here");
 cb.setOAuthConsumerSecret("your consumer secret goes here");
 cb.setOAuthAccessToken("your access token goes here");
 cb.setOAuthAccessTokenSecret("your access token secret goes here"); 

twitterFactory = new TwitterFactory(cb.build());
twitter = twitterFactory.getInstance();

}


void getSearchTweets() {

  try {
    Query query = new Query(queryStr);
    // We're only looking for the 10 most recent tweets.
    query.setCount(10);
    QueryResult result = twitter.search(query);
    ArrayList tweets = (ArrayList) result.getTweets();

    ee = new String[tweets.size()];
    tweets_test = new String[tweets.size()];
    for (int i = 0; i < tweets.size(); i++) {
      Status tweet = (Status) tweets.get(i);
        ee[i] = tweet.getText();

/*
In case the display is garbled, you can at least see what's being
pulled when each search occurs.
*/
    println(i + ". " + ee[i]);
    
    }

    
    for (int i = 0; i < ee.length; i++) {
    }
  }

  catch (TwitterException e) {
    println("Search tweets: " + e);
    text("Search tweets: " + e, 10, 30, 600, 400);
  }
}

