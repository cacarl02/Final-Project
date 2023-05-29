class UserSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :id, :email, :firstname, :lastname, :role, :photo_data, :balance, :is_verified, :created_at
end
