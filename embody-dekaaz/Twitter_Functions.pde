
void getSearchTweets() {

  try {
    // Note: these 2 paging lines are for returning 1 search result
    Query query = new Query(queryStr);
    query.setPage(1);
    query.setRpp(max_tweets);
    QueryResult result = twitter.search(query);
    ArrayList tweets = (ArrayList) result.getTweets();

    ee = new String[tweets.size()];
    tweets_test = new String[tweets.size()];
    for (int i = 0; i < tweets.size(); i++) {
      Tweet tweet = (Tweet) tweets.get(i);
        ee[i] = tweet.getText();

/*
In case the display is garbled, you can at least see what's being
pulled when each search occurs.
*/
    println(i + ". " + ee[i]);

    }

    
    for (int i = 0; i < ee.length; i++) {
    }
    
    initializeEE();
    query = null;
    result = null;
    tweets = null;
  }

  catch (TwitterException e) {
    println("Search tweets: " + e);
    text("Search tweets: " + e, 10, 30, 600, 400);
  }
}

