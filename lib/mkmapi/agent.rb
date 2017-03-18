require 'simple_oauth'
require 'oj'
require 'zlib'
require 'stringio'

module Mkmapi
  class Agent < Struct.new(:connection, :auth)

    attr_reader :last

    def get(path, gzip = false, data_node = '')
      process(:get, path, gzip, data_node)
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

      def process(method, path, gzip = false, data_node = '')
        json_path = "output.json/#{ path }"
        endpoint = connection.url_prefix.to_s + "/" + json_path

        @last = connection.send(method, json_path, {}, authorization: oauth(method, endpoint))
        json_data = Oj.load(@last.body)

        if (gzip && json_data && json_data[data_node])
          data = Base64.decode64(json_data[data_node])

          Zlib::GzipReader.new(StringIO.new(data))
        else
          json_data
        end
      end

      def oauth(method, url, options = {}, query = {})
        header = SimpleOAuth::Header.new(method, url, options, auth)

        signed_attributes = { realm: url }.update(header.signed_attributes)
        attributes = signed_attributes.map { |(k, v)| %(#{k}="#{v}") }

        "OAuth #{ attributes * ', ' }"
      end

  end
end
