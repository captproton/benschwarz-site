module Germanforblack
  unless defined?(Cache)
    require 'moneta'
    begin
      require 'moneta/memcache'
      Cache = Moneta::Memcache.new(:server => ENV['MEMCACHE_SERVERS'].split(','), :namespace => ENV['MEMCACHE_NAMESPACE'])
    rescue
      puts "*** Using memory cache store"
      require 'moneta/memory'
      Cache = Moneta::Memory.new
    end
  end
end