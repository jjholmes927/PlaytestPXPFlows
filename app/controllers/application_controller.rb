require 'gocardless_pro'
class ApplicationController < ActionController::Base
    def initialize
      super
      @client = GoCardlessPro::Client.new(
        access_token: ENV['GC_ACCESS_TOKEN_SANDBOX'],
        environment: :sandbox
      )
    end
  end
