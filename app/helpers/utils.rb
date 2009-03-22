module Application
  module Helpers
    module Utils
      include Rack::Utils
      alias :h :escape_html
      
      def partial(template, *args)
          options = args.extract_options!
          options.merge!(:layout => false)
          if collection = options.delete(:collection) then
            collection.inject([]) do |buffer, member|
              buffer << erb(template, options.merge(
                                        :layout => false, 
                                        :locals => {template.to_sym => member}
                                      )
                           )
            end.join("\n")
          else
            haml(template, options)
          end
        end
    end
  end
end