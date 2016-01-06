json.array!(@verifications) do |verification|
  json.extract! verification, :id, :speaker_id
  json.url verification_url(verification, format: :json)
end
