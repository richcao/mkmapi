module Mkmapi
  class Base < Struct.new(:agent, :data)

    def data
      super || __load
    end

    private

      def __load
        raise NotImplementedError
      end

  end
end
