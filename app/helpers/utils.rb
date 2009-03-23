module Application
  module Helpers
    module Utils
      include Rack::Utils
      alias :h :escape_html
      
      def partial(template, locals={})
        haml("_#{template}".to_sym, :locals => locals, :layout => false)
      end
    end
  end
end