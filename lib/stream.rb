require 'digest/sha1'

Smoke.data(:flickr) do
  url "http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=1e99cd67056e382c382826fb95436782&user_id=36821533%40N00&tags=germanforblack-site&format=json&nojsoncallback=1&extras=url_s", :type => :json
  path :photos, :photo
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