module ApplicationHelper

  def current_speaker
    return nil if session[:session_token].nil?
    @current_speaker ||= Speaker.find_by_session_token(session[:session_token])
  end

  def speaker_owns?(object)
  	!!current_speaker && (object.speaker == current_speaker)
  end

  def is_admin?
  	!!current_speaker && current_speaker.id == 1
  end

end
