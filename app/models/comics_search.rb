class ComicsSearch
  PAGE_SIZE = 15

  attr_reader :page

  def initialize page: 0
    @page = page.to_i
  end

  def response
    @response ||= Marvel::Client.new('/v1/public/comics', options).get.parsed_response
  end

  def comics
    response['data']['results'].map do |attrs|
      Comic.from_attributes(attrs)
    end
  end

  def options
    { query: query }
  end

  def query_base
    {
      limit: PAGE_SIZE,
      orderBy: 'onsaleDate',
      format: 'comic',
      formatType: 'comic',
      offset: offset
    }
  end

  def query
    query_base
  end

  def offset
    PAGE_SIZE * page
  end

  def total
    response['data']['total'].to_i
  end

  def next_page
    offset + PAGE_SIZE < total ? page + 1 : nil
  end

   def previous_page
     offset - PAGE_SIZE < 0 ? nil : page - 1
   end
end
