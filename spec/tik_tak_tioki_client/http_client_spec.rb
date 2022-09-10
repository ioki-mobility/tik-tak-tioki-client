# frozen_string_literal: true

RSpec.describe TikTakTiokiClient::HttpClient, vcr: { allow_unused_http_interactions: true } do
  subject(:client) { described_class.new }

  describe "#get" do
    context "successful request" do
      it "calls the corresponding API endpoint" do
        expected_url = TikTakTiokiClient.config.api_base_url + "/api/game?player_token=TOKEN"

        stub_request(:get, expected_url)

        client.get("/game", query_params: { player_token: "TOKEN" })
      end
    end

    context "failed request" do
      it "raises a Faraday exception" do
        expected_url = TikTakTiokiClient.config.api_base_url + "/api/game?player_token=TOKEN"

        stub_request(:get, expected_url).to_return(status: 422)

        expect do
          client.get("/game", query_params: { player_token: "TOKEN" })
        end.to raise_error(Faraday::UnprocessableEntityError)
      end
    end
  end

  describe "#post" do
    context "successful request" do
      it "calls the corresponding API endpoint" do
        expected_url = TikTakTiokiClient.config.api_base_url + "/api/move?player_token=TOKEN"

        stub_request(:post, expected_url).with(body: { field: 1, next_move_token_token: "MOVE_TOKEN" })

        client.post("/move", data: { field: 1, next_move_token_token: "MOVE_TOKEN" },
                             query_params: { player_token: "TOKEN" })
      end
    end

    context "failed request" do
      it "raises a Faraday exception" do
        expected_url = TikTakTiokiClient.config.api_base_url + "/api/move?player_token=TOKEN"

        stub_request(:post, expected_url).to_return(status: 422)

        expect do
          client.post("/move", data: { field: 1, next_move_token_token: "INVALID_TOKEN" },
                               query_params: { player_token: "TOKEN" })
        end.to raise_error(Faraday::UnprocessableEntityError)
      end
    end
  end
end
