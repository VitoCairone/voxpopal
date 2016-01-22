class Issue < ActiveRecord::Base
  belongs_to :speaker
  has_many :choices
  has_many :voices
  accepts_nested_attributes_for :choices, allow_destroy: true

  def self.unseen_by_speaker(speaker, limit=3, offset=0)
    return nil unless speaker.id.is_a? Integer
    Issue.joins(<<-JOIN_STRING
          LEFT OUTER JOIN voices
          ON voices.issue_id = issues.id
          AND voices.speaker_id = #{speaker.id}
          JOIN_STRING
          )
          .where("voices.id IS NULL") #.order(boost: :desc)
          .limit(limit)
          .offset(offset)
  end

  def self.seen_by_speaker(speaker, limit=3, offset=0)
    return nil unless speaker.id.is_a? Integer
    Issue.joins(:voices)
         .where(voices: { speaker_id: speaker.id }) #.order(boost: :desc)
         .limit(limit)
         .offset(offset)
  end

  # this really should be a Speaker method
  def self.update_reserved_session_tokens(reserve_token)
    Issue.connection.update(<<-UPDATE_STRING
    UPDATE speakers
    SET session_token = '#{reserve_token}'
    WHERE id IN (
      SELECT id
      FROM speakers
      WHERE session_token = 'LOGGED_OUT_GUEST'
      LIMIT 20
    )
    UPDATE_STRING
    )
  end

  def self.get_free_codename_issue_for(id)
    # Upon invoking, reserve 20 LOGGED_OUT_GUEST codenames
    # for this guest by assigning their session_token to
    # RESERVED_FOR_[id].
    return nil unless id.is_a? Integer
    reserved_name_token = "RESERVED_FOR_#{id}"
    n = Issue.update_reserved_session_tokens(reserved_name_token)
    speakers = Speaker.where(session_token: reserved_name_token).limit(20)
    if speakers.nil? or speakers.length < 20
      # create plenty more guests and try one more time
      Speaker.create_guests(200)
      n = Issue.update_reserved_session_tokens(reserved_name_token)
      speakers = Speaker.where(session_token: reserved_name_token).limit(20)
    end

    # These names must be released and become guests once
    # the guest picks a name and completes registration

    issue = Issue.new(speaker_id: id, text: "Which Speaker codename do you want?")

    choice_params_arr = speakers.pluck(:codename).map{ |cn| {text: cn}}
    issue.choices.build(choice_params_arr)

    issue
  end

  def to_s
    "#{codename}-#{id}"
  end

end
