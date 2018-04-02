class Marvel::Client
  PUBLIC_KEY = Rails.configuration.x.marvel.public_key
  PRIVATE_KEY = Rails.configuration.x.marvel.private_key
  DEBUG = ENV.fetch('MARVEL_CLIENT_DEBUG', false).present?

  include HTTParty
  base_uri Rails.configuration.x.marvel.base_url

  attr_reader :path, :parameters

  def initialize path, options = {}
    @path = path
    @parameters = options.delete(:query) { {} }
    @options = options
    @options.merge(debug_output: $stdout) if DEBUG
  end

  def get
    self.class.get(path, options)
  end

  private

  def options
    @options.merge(query: query)
  end

  def query
    authentication_parameters.merge(parameters)
  end

  def authentication_parameters
    {
      ts: salt,
      apikey: PUBLIC_KEY,
      hash: md5_hash
    }
  end

  def md5_hash
    Digest::MD5.hexdigest([salt, PRIVATE_KEY, PUBLIC_KEY].join)
  end

  def salt
    @salt ||= SecureRandom.hex(10)
  end
end
