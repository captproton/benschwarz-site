module Germanforblack
  unless defined?(Cache)
    require 'moneta'
    require 'moneta/memory'
    Cache = Moneta::Memory.new
  end
end