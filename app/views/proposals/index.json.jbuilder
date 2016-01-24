json.array!(@proposals) do |proposal|
  json.extract! proposal, :id, :code, :speaker_id, :text, :upvotes, :downvotes, :boost
  json.url proposal_url(proposal, format: :json)
end
