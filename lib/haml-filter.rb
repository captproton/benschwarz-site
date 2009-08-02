module Haml 
  module Filters 
    # Forces RDiscount to process with Smarty Pants. 
    module Markdown 
      include ::Haml::Filters::Base 
      lazy_require 'rdiscount' 
      def render(text) 
        ::RDiscount.new(text, :smart).to_html 
      end 
    end 
  end 
end