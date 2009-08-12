module Germanforblack
  unless defined?(Cache)
    require 'moneta'
    require 'moneta/memcache'
    Cache = Moneta::Memcache.new(:server => ENV['MEMCACHE_SERVERS'].split(','), :namespace => ENV['MEMCACHE_NAMESPACE'])
  end
end