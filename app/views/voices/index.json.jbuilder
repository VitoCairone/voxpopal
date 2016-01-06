json.array!(@voices) do |voice|
  json.extract! voice, :id, :speaker_id, :choice_id, :level
  json.url voice_url(voice, format: :json)
end
