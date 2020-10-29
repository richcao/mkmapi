require "bundler/setup"
require "faraday"

module Mkmapi
  path = ->(basename) {
    File.expand_path File.join("..", "mkmapi", basename), __FILE__
  }
  autoload :Agent, path["agent"]
  autoload :Session, path["session"]
  autoload :Base, path["base"]
  autoload :Account, path["account"]
  autoload :Marketplace, path["marketplace"]

  def self.connect(url = "https://api.cardmarket.com/ws/v2.0")
    @connection = Faraday.new url, ssl: { verify: false } do |faraday|
      # faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
  end
  def self.connection
    @connection ||= connect
  end

  def self.auth(params)
    Session.new connection, params
  end
end
