module Marvel
  class ComicsSearch < Search
    attr_reader :characters

    def initialize characters: [], **options
      @characters = characters
      super options
    end

    def perform
      Marvel::Client.new('/v1/public/comics', options).get.parsed_response
    end

    def query
      query = {
        orderBy: 'onsaleDate',
        format: 'comic',
        formatType: 'comic'
      }
      query.merge!(characters: characters.join(',')) if characters.present?

      query
    end

    def comics
      response['data']['results'].map do |attrs|
        Comic.from_attributes(attrs)
      end
    end
  end
end
