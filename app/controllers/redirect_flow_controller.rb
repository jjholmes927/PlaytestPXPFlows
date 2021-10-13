require 'gocardless_pro'

class RedirectFlowController < ApplicationController
    SESSION_TOKEN = ("a".."z").to_a.sample(10).join
    def initialize
        super
        @session_token = SESSION_TOKEN
      end

    def index
        
    end

    def create
        begin
        redirect_flow = @client.redirect_flows.create(
            params: {
                session_token: @session_token,
                success_redirect_url: 'http://localhost:3000/redirectflow/success'
            }
        )

        redirect_to redirect_flow.redirect_url

        rescue StandardError => e
            puts e
        end
    end
    
    def success
        @client.redirect_flows.complete(params[:redirect_flow_id], params: { session_token: @session_token })      
    end
    
end