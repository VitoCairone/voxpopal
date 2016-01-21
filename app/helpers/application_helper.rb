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

  def replace_issue_in_history
    # why is it that current_speaker.speaker_history works
    # but speaker_history.issue_spare_1 doesn't?
    @history = current_speaker.speaker_history
    spare_issue_ids = [
      @history.issue_spare_1_id,
      @history.issue_spare_2_id,
      @history.issue_spare_3_id
    ]
    spare_issue_ids -= [nil]
    unord_spare_issues = Issue.find(spare_issue_ids)

    # puts "@@@@@ unord_spare_issues: #{unord_spare_issues}"

    @spare_issues = []
    spare_issue_ids.each do |id|
      @spare_issues += [unord_spare_issues.find{|record| record.id == id}]
    end

    # puts "@@@@@ @spare_issues: #{@spare_issues}"
    
    unseen_issues = Issue.unseen_by_speaker(current_speaker, limit=5)
    possible_new_issues = unseen_issues - (@spare_issues + [@issue])
    new_issue = possible_new_issues.sample
    replace_slot = @spare_issues.find_index @issue
    replacement = new_issue.nil? ? nil : new_issue.id
    if [0,1,2].include? replace_slot
      case replace_slot
        when 0
          @history.issue_spare_1_id = replacement
        when 1
          @history.issue_spare_2_id = replacement
        when 2
          @history.issue_spare_3_id = replacement
      end
      @spare_issues[replace_slot] = new_issue unless new_issue.nil?
      @history.save
    end
  end
end
