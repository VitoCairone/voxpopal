json.array!(@issues) do |issue|
  json.extract! issue, :id, :codename, :speaker_id, :text
  json.url issue_url(issue, format: :json)
end
