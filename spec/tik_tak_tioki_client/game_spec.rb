# frozen_string_literal: true

RSpec.describe TikTakTiokiClient::Game do
  let!(:game) do
    VCR.use_cassette("game creation") do
      described_class.create!
    end
  end

  let!(:joined_game) do
    VCR.use_cassette("game joining") do
      described_class.join!(game.name)
    end
  end

  let!(:joinable_game_list) do
    VCR.use_cassette("joinable game list") do
      described_class.all_joinables
    end
  end

  context "retrieving a game instance" do
    describe "creating a Game" do
      it "has a valid cassette" do
        expect(game.name).to be
      end
    end

    describe "joining a Game" do
      it "has a valid cassette" do
        expect(joined_game.name).to eql(game.name)
      end
    end

    describe "listing all joinable games" do
      it "has a valid cassette" do
        expect(joinable_game_list).not_to be_empty
      end
    end
  end

  context "operating on a game instance" do
    describe "fetching the game state" do
      it "loads the current game state" do
        response = double
        response_body = game.data.to_h
        allow(response).to receive(:body).and_return(response_body)

        payload = {
          query_params: { player_token: game.player_token}
        }

        expect(game.http_client).to receive(:get).with("/game", payload).and_return(response)
        expect(game.fetch).to eql(response_body)
      end
    end

    describe "updating the game state" do
      it "loads the current game state" do
        fake_state = { name: "Hello-World-123" }
        expect(game).to receive(:fetch).and_return(fake_state)

        game.update!

        expect(game.name).to eql("Hello-World-123")
      end
    end

    describe "making a move" do
      it "calls the move endpoint on the http client" do
        response = double
        allow(response).to receive(:body)

        payload = {
          data: {field: 1, next_move_token: game.next_move_token },
          query_params: { player_token: game.player_token}
        }

        expect(game.http_client).to receive(:post).with("/move", payload).and_return(response)

        game.make_move(1)
      end
    end

    describe "inspecting a game instance" do
      it "renders a custom string to inspect the object" do
        expect(game.inspect).to eql(%q(#<TikTakTiokiClient::Game name: sharp-fog-8700, player_role: x, state: awaiting_join, created_at: 2022-08-21T10:54:18.059Z, updated_at: 2022-08-21T10:54:18.059Z, board: f-f-f-f-f-f-f-f-f>))
      end
    end
  end
end
