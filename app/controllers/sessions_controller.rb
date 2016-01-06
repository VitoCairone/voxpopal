class SessionsController < ApplicationController
	# include ApplicationHelper

	def create
    @speaker = Speaker.find_by_email(params[:email])
    if @speaker && @speaker.password_hash == password_hash(params[:password])
      login(@speaker)
      redirect_to issues_url
    else
      redirect_to new_session_url
    end
  end

  def new
  	logout
  end

  private

  def password_hash(password)
  	# use BCrypt
  	return password
  end

  def login(speaker)
  	token = SecureRandom.urlsafe_base64(16)
    speaker.session_token = token
    speaker.save
    session[:session_token] = token
  end

  def logout
  	speaker = current_speaker
    if speaker
      speaker.session_token = SecureRandom.urlsafe_base64(14)
      speaker.save
    end
    session[:session_token] = "LOGGED_OUT"
    @current_speaker = nil
  end

end
