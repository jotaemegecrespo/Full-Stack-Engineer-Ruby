class Character
  include ActiveModel::Model

  attr_accessor :id, :name

  def self.from_attributes attrs
    new(attrs.symbolize_keys.slice(:id, :name))
  end
end
