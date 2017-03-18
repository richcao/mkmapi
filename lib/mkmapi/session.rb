module Mkmapi
  class Session

    attr_reader :agent, :account, :marketplace

    def initialize(connection, authentication)
      @agent = Agent.new(connection, authentication)
      @marketplace = Marketplace.new(@agent)
    end
  end
end
