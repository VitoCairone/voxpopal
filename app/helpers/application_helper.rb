module ApplicationHelper

  def current_speaker
    if session[:session_token].nil?
      return login_free_guest_speaker  
    elsif @current_speaker ||= Speaker.find_by_session_token(session[:session_token])
      return @current_speaker
    else
      return login_free_guest_speaker
    end
  end

  def login_free_guest_speaker
    guest_speaker = Speaker.find_guest
    login(guest_speaker)
    @current_speaker = guest_speaker
  end

  def speaker_owns?(object)
  	(!!current_speaker) and (object.speaker_id == current_speaker.id)
  end

  def is_guest?
    current_speaker.guest
  end

  def is_admin?
  	current_speaker.admin
  end

  # move / reimplement ?
  def login(speaker)
    token = SecureRandom.urlsafe_base64(20)
    speaker.session_token = token
    speaker.save
    session[:session_token] = token
    @current_speaker = speaker
  end

  # move / reimplement ?
  def logout(reassign=true)
    unless current_speaker.nil?
      speaker = current_speaker
      speaker.session_token = SecureRandom.urlsafe_base64(19)
      speaker.save
    end
    session[:session_token] = SecureRandom.urlsafe_base64(18)
    if reassign
      @current_speaker = nil
      current_speaker # force re-assignment by default method
    end
  end

  # the effects of this function are
  # (1) to update the database issue_spare_X_id values and
  # (2) set @spare_issues
  def replace_issue_in_history
    # note to self -- strongly consider replacing the entire
    # implementation of this functionality with a single nonreferential
    # viewslot int on speaker_history model
    
    # why is it that current_speaker.speaker_history works
    # but speaker_history.issue_spare_1 doesn't?
    @history = current_speaker.speaker_history
    spare_issue_ids = [
      @history.issue_spare_1_id,
      @history.issue_spare_2_id,
      @history.issue_spare_3_id
    ]

    # actually set @spare_issues for display by the template
    begin
      unord_spare_issues = Issue.find(spare_issue_ids - [nil])
    rescue ActiveRecord::RecordNotFound => e
      unord_spare_issues = []
      spare_issue_ids = []
    end

    @spare_issues = []
    spare_issue_ids.each do |id|
      @spare_issues += [unord_spare_issues.find{|record| record.id == id}]
    end
    @spare_issues -= [nil]
    
    # find the next issue to slot in
    # right now we're doing a new search every request, eventually consider
    # some manner of preloading/caching
    unseen_issues = Issue.unseen_by_speaker(current_speaker, limit=5)
    possible_new_issue_ids = unseen_issues.map(&:id) - (spare_issue_ids + [@issue.id, nil])
    new_issue_id = possible_new_issue_ids.sample

    replace_slot = spare_issue_ids.find_index @issue.id
    replacement = new_issue_id

    if [0,1,2].include? replace_slot
      case replace_slot
        when 0
          @history.issue_spare_1_id = replacement
        when 1
          @history.issue_spare_2_id = replacement
        when 2
          @history.issue_spare_3_id = replacement
      end
      @history.save

      unless new_issue_id.nil? or @spare_issues.size <= replace_slot
        @spare_issues[replace_slot] = unseen_issues.find{ |x| x.id == new_issue_id }
      end
    end
  end
end
