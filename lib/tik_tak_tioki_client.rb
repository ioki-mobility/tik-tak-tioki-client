# frozen_string_literal: true

require "active_support/configurable"
require_relative "tik_tak_tioki_client/version"
require_relative "tik_tak_tioki_client/game"
require_relative "tik_tak_tioki_client/http_client"

module TikTakTiokiClient
  include ActiveSupport::Configurable

  configure do |config|
    config.api_base_url = "https://tik-tak-tioki.fly.dev"
  end
end
