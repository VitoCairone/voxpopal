json.array!(@comments) do |comment|
  json.extract! comment, :id, :speaker_id, :parent_id, :parent_type
  json.url comment_url(comment, format: :json)
end
