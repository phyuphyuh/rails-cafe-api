json.array! @cafes do |cafe|
  json.extract! cafe, :id, :title, :address
end
