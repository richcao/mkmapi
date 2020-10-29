require "simple_oauth"
require "oj"

module Mkmapi
  class Agent < Struct.new(:connection, :auth)
    attr_reader :last

    def get(path, query_params = {})
      process(:get, path, query_params)
    end

    def put(path, body)
      raise NotImplementedError
    end

    def post(path, body)
      raise NotImplementedError
    end

    def delete(path)
      raise NotImplementedError
    end

    private

    def process(method, path, query_params = {})
      json_path = "output.json/#{path}"
      endpoint = connection.url_prefix.to_s + "/" + json_path

      @last = connection.send(method, json_path, query_params, authorization: oauth(method, endpoint))
      Oj.load(@last.body)
    end

    def oauth(method, url, options = {}, query = {})
      header = SimpleOAuth::Header.new(method, url, options, auth)

      signed_attributes = { realm: url }.update(header.signed_attributes)
      attributes = signed_attributes.map { |(k, v)| %(#{k}="#{v}") }

      "OAuth #{attributes * ", "}"
    end
  end
end
