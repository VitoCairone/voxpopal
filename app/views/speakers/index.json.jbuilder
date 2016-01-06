json.array!(@speakers) do |speaker|
  json.extract! speaker, :id, :codename, :name, :email, :password_hash, :starsign, :birth_month, :birth_year, :verification_id, :level, :session_token, :recall_token, :logged_in, :last_action
  json.url speaker_url(speaker, format: :json)
end
