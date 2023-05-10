class UserSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :email, :firstname, :lastname, :role, :photo_data, :balance
end
