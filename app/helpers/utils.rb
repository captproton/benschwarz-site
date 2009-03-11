module Application
  module Helpers
    module Utils
      include Rack::Utils
      alias :h :escape_html
    end
  end
end