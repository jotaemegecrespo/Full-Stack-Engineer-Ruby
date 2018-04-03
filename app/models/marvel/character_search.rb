module Marvel
  class CharacterSearch < Search
    attr_reader :character

    def initialize character:, **options
      @character = character

      super options
    end

    def perform
      Marvel::Client.new('/v1/public/characters', options).get.parsed_response
    end

    def query
      {
        name: character
      }
    end

    def characters
      response['data']['results'].map do |attrs|
        Character.from_attributes(attrs)
      end
    end
  end
end
