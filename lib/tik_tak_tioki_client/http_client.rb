# frozen_string_literal: true

require "faraday"
require "active_support/core_ext/object/to_query"

module TikTakTiokiClient
  class HttpClient
    def get(path, query_params: {})
      url = build_url(path, query_params)
      connection.get(url)
    end

    def post(path, data: nil, query_params: {})
      url = build_url(path, query_params)
      connection.post(url, data)
    end

    private

    def build_url(path, query_params = {})
      "#{TikTakTiokiClient.config.api_base_url}/api#{path}?#{query_params.to_query}"
    end

    def connection
      @conn ||= Faraday.new do |f|
        f.request :json
        f.response :json
        f.response :logger, nil, { bodies: true }
        # will throw a Faraday::Error in case of a 4xx/5xx response
        # https://lostisland.github.io/faraday/middleware/raise-error
        f.response :raise_error
        f.adapter :net_http
      end
    end
  end
end
