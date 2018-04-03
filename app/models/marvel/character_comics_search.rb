module Marvel
  class CharacterComicsSearch < Search

    def perform
      Marvel::Client.new('/v1/public/comics', options).get.parsed_response
    end

    def query
      {
        orderBy: 'onsaleDate',
        format: 'comic',
        formatType: 'comic'
      }
    end
  end
end
