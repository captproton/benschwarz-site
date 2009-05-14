Smoke.feed(:twitter) do
  url "http://twitter.com/statuses/user_timeline/14431882.rss"
  discard :title, /(@|#)/
end

Smoke.feed(:delicious) do
  url "http://feeds.delicious.com/v2/rss/bschwarz?count=15"
end

Smoke.data(:flickr) do
  url "http://api.flickr.com/services/feeds/photos_public.gne?id=36821533@N00&lang=en-us&format=json&nojsoncallback=1"
  path :items
  rename :published => :pubDate
end

Smoke.join(:twitter, :delicious, :flickr) do
  sort :pubDate
end

Smoke.rename(:twitter_delicious_flickr_joined => :stream)