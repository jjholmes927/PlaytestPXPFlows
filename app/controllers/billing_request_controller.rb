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
                auto_fulfil: false,
            }
        )

        @billing_request_id = billing_request.id
        puts billing_request.id


        rescue StandardError => e
            puts e.inspect
        end
    end

    def create_flow
        begin
            billing_request_flow = @client.billing_request_flows.create(
                params: {
                    redirect_uri: "http://localhost:3000/billingrequest/success",
                    auto_fulfil: false,
                    links: {
                        billing_request: @billing_request.id,
                    }
                }
            )

            redirect_to billing_request_flow.authorisation_url

        rescue StandardError => e
            puts e.inspect
        end
    end

    def success
        @client.billing_requests.fulfil(@billing_request_id)
    end
end
