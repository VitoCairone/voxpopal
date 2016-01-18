module ApplicationHelper

  def current_speaker
    if session[:session_token].nil?
      guest_speaker = Speaker.find_guest
      login(guest_speaker)
      @current_speaker = guest_speaker
    end
    @current_speaker ||= Speaker.find_by_session_token(session[:session_token])
  end

  def speaker_owns?(object)
  	(!!current_speaker) and (object.speaker_id == current_speaker.id)
  end

  # delete / replace
  def is_guest?
    @is_guest ||= (!!current_speaker) and (current_speaker.id != 1)
  end

  # delete / replace
  def is_admin?
  	@is_admin ||= (!!current_speaker) and (current_speaker.id == 1)
  end

  # move / reimplement ?
  def login(speaker)
    token = SecureRandom.urlsafe_base64(20)
    speaker.session_token = token
    speaker.save
    session[:session_token] = token
  end

  # move / reimplement ?
  def logout
    speaker = current_speaker
    speaker.session_token = SecureRandom.urlsafe_base64(19)
    speaker.save
    session[:session_token] = SecureRandom.urlsafe_base64(18)
    @current_speaker = nil
  end

end
