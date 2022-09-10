# frozen_string_literal: true

require "active_support/core_ext/module/delegation"
require "ostruct"

module TikTakTiokiClient
  class Game
    attr_accessor :http_client, :data

    delegate_missing_to :data

    def self.create!
      client = HttpClient.new
      response = client.post("/game")
      Game.new(response.body, client)
    end

    def self.all_joinables
      client = HttpClient.new
      response = client.get("/join")
      response.body
    end

    def self.join!(game_name)
      client = HttpClient.new
      response = client.post("/join", data: { name: game_name })
      Game.new(response.body, client)
    end

    def initialize(data, http_client)
      self.data = data
      self.http_client = http_client || HttpClient.new
    end

    def fetch
      response = http_client.get("/game", query_params: { player_token: player_token })
      response.body
    end

    def update!
      self.data = fetch
    end

    def make_move(field)
      data = {
        next_move_token: next_move_token,
        field: field
      }
      response = http_client.post("/move", data: data, query_params: { player_token: player_token })
      self.data = response.body
    end

    def inspect
      fields = %i[name player_role state created_at updated_at]
      inspection = fields.map { |field| "#{field}: #{public_send(field)}" }.join(", ")
      inspection << ", board: " << board.join("-")
      "#<#{self.class.name} #{inspection}>"
    end

    private

    def data=(data)
      @data = OpenStruct.new(data)
    end
  end
end
