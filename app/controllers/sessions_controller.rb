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

end
