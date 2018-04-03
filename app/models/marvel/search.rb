module Marvel
  class Search
    PAGE_SIZE = 15

    attr_reader :page

    def initialize page: 0, **options
      @page = page.to_i
    end

    def response
      @response ||= perform
    end

    def perform
      raise NotImplementedError
    end

    def options
      { query: query_base.merge(query) }
    end

    def query_base
      {
        limit: PAGE_SIZE,
        offset: offset
      }
    end

    def query
      {}
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
end
