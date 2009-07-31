require 'digest/sha1'

# Twitter status updates
# Smoke.feed(:twitter) do
#   url "http://twitter.com/statuses/user_timeline/14431882.rss"
#   emit do
#     insert :source, "twitter"
#     discard :title, /(@|#)/
#     
#     transform :title, :description do |t|
#       t.gsub("benschwarz: ", '')
#     end
#   end
# end

Smoke.data(:flickr) do
  url "http://api.flickr.com/services/feeds/photos_public.gne?id=36821533@N00&lang=en-us&format=json&nojsoncallback=1"
  path :items
  
  emit do
    insert :source, self.name
    rename :published => :created_at
  end
end

Smoke.data(:twitter) do
  url "http://twitter.com/users/show.json?screen_name=benschwarz"
end

Smoke.feed(:delicious) do
  url "http://feeds.delicious.com/v2/rss/bschwarz?count=5"
end

Smoke.data(:upcoming) do
  url "http://upcoming.yahooapis.com/services/rest/?method=user.getWatchlist&api_key=7c06afe3f8&user_id=908522&show=upcoming&format=json"
  path :rsp, :event

  emit do
    keep :status, /attend/
    truncate 1
  end
end

Smoke.data(:github) do
  url "http://github.com/api/v2/json/repos/show/benschwarz"
  path :repositories
  
  emit do
    sort :watchers
    reverse
    truncate 5
  end
end

Smoke.data(:slideshare) do
  prepare do
    timestamp = Time.now.to_i
    hash = Digest::SHA1.hexdigest("FeXBxg0G#{timestamp}")
    url "http://www.slideshare.net/api/2/get_slideshows_by_user?username_for=benschwarz&api_key=uQqJ57cz&ts=#{timestamp}&hash=#{hash}"
  end
  
  path :User, :Slideshow
end