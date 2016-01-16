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
  	(!!current_speaker) and (object.speaker == current_speaker)
  end

  def is_guest?
    @is_guest ||= (!!current_speaker) and (guest_speaker_list.include? current_speaker.id)
  end

  def is_admin?
  	@is_admin ||= (!!current_speaker) and (current_speaker.id == 1)
  end

  def password_hash(password)
    # use BCrypt
    password
  end

  def login(speaker)
    token = SecureRandom.urlsafe_base64(16)
    speaker.session_token = token
    speaker.save
    session[:session_token] = token
  end

  def logout
    speaker = current_speaker
    if is_guest?
      speaker.session_token = "LOGGED_OUT_GUEST"
    else
      speaker.session_token = SecureRandom.urlsafe_base64(14)
    end
    speaker.save
    session[:session_token] = "LOGGED_OUT_GUEST"
    @current_speaker = nil
  end

  def guest_speaker_list 
    [6, 7, 10]
  end

end
