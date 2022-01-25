class BillingRequestController < ApplicationController

    def index
    end

    def show
        @billing_request = @client.billing_requests.get(params[:id])
    end

    def create
        begin
        billing_request = @client.billing_requests.create(
            params: {
		        mandate_request: {
	                scheme: 'bacs'
                },
            }
        )

        @billing_request_id = billing_request.id
        billing_request_flow = @client.billing_request_flows.create(
            params: {
                redirect_uri: "http://localhost:3000/billingrequest/success",
                links: {
                    billing_request: billing_request.id,
                },
            }
        )

        redirect_to billing_request_flow.authorisation_url

        rescue StandardError => e
            puts e.inspect
        end
    end

    def success
#   only needed when testing auto_fulfil: false flows   
#	@client.billing_requests.fulfil(@billing_request)
    end
end
