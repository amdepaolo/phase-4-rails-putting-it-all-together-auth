class UserSerializer < ActiveModel::Serializer
  attributes :id, :bio, :username, :image_url
end
