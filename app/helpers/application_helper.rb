module ApplicationHelper

  def current_speaker
    return nil if session[:session_token].nil?
    @current_speaker ||= Speaker.find_by_session_token(session[:session_token])
  end

end
