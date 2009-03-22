require 'base64'

module Application
  module Spec
    module Helper
      def auth(method, path, params={})
        send(method, path, params, {'HTTP_AUTHORIZATION'=> encode_credentials})
      end
      
      private
      def encode_credentials
        "Basic " + Base64.encode64("#{Application.config[:auth][:username]}:#{Application.config[:auth][:password]}")
      end
    end
  end
end