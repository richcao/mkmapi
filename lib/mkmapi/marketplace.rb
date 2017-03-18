require 'csv'
require 'zlib'
require 'stringio'

module Mkmapi
  class Marketplace < Struct.new(:agent)

    def priceguide
      json_data = agent.get("priceguide")

      if (json_data && json_data["priceguidefile"])
        data = Base64.decode64(json_data["priceguidefile"])
        gzip = Zlib::GzipReader.new(StringIO.new(data))

        keys = ['id', 'average', 'low', 'trend', 'suggested', 'foil', 'foil_low', 'foil_trend' ]
        skip_first = gzip.readline # Skip the header

        CSV.parse(gzip.read).map do |a|
          item = keys.zip(a.map(&:to_f))
          item[0][1] = item[0][1].to_i

          Hash[ item ]
        end
      end
    end

    def productlist
      json_data = agent.get("productlist")

      if (json_data && json_data["productsfile"])
        data = Base64.decode64(json_data["productsfile"])
        gzip = Zlib::GzipReader.new(StringIO.new(data))

        keys = ['id', 'name', 'category_id', 'category', 'expansion_id', 'metacard_id', 'date_added' ]
        skip_first = gzip.readline # Skip the header

        CSV.parse(gzip.read).map do |a|
          item = keys.zip(a)
          item[0][1] = item[0][1].to_i
          item[2][1] = item[2][1].to_i
          item[4][1] = item[4][1].to_i
          item[5][1] = item[5][1].to_i
          Hash[ item ]
        end
      end
    end

    def expansions(game_id = 1)
      agent.get("games/#{game_id}/expansions")['expansion'].
        each {|g| g['id'] = g.delete('idExpansion') }
    end

    def singles(expansion_id = 1)
      agent.get("expansions/#{expansion_id}/singles")
    end

    def games
      agent.get("games")['game'].
        each {|g| g['id'] = g.delete('idGame') }
    end

    def card_by_name(name, game_id = 1, language_id = 1)
      product(name, game_id, language_id, true)
    end

    def search(name, game_id = 1, language_id = 1)
      product(name, game_id, language_id, false)
    end

    private

      def product(name, game_id, language_id, search)
        clean_name = URI.escape(name.gsub(/[^a-zA-Z0-9 ]/, '').downcase)
        path = ["products", clean_name, game_id, language_id, search].join("/")

        agent.get(path)['product']
      end

  end
end
