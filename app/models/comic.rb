class Comic
  include ActiveModel::Model

  attr_accessor :id, :title, :thumbnail

  def self.from_attributes attrs
    new(attrs.symbolize_keys.slice(:id, :title, :thumbnail))
  end

  def image_url
    "#{thumbnail['path']}/portrait_xlarge.#{thumbnail['extension']}"
  end
end
