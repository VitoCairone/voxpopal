json.array!(@choices) do |choice|
  json.extract! choice, :id, :issue_id, :speaker_id, :text, :voice_tally_1, :voice_tally_2, :voice_tally_3, :current_rank
  json.url choice_url(choice, format: :json)
end
