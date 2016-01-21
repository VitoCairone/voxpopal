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
  end

  # move / reimplement ?
  def logout
    speaker = current_speaker
    speaker.session_token = SecureRandom.urlsafe_base64(19)
    speaker.save
    session[:session_token] = SecureRandom.urlsafe_base64(18)
    @current_speaker = nil
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
    unord_spare_issues = Issue.find(spare_issue_ids - [nil])
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

      unless new_issue_id.nil?
        @spare_issues[replace_slot] = unseen_issues.find{ |x| x.id == new_issue_id }
      end
    end
  end
end
