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

  def self.get_free_codename_issue_for(id)
    # Upon invoking, reserve 20 LOGGED_OUT_GUEST codenames
    # for this guest by assigning their session_token to
    # RESERVED_FOR_[id].
    return nil unless id.is_a? Integer
    reserved_name_token = "RESERVED_FOR_#{id}"

    # first try to find the reserved names that already exist
    speakers = Speaker.where(session_token: reserved_name_token).limit(20)

    # if they weren't found, try to create some
    unless speakers and speakers.length == 20
      n = Speaker.update_reserved_session_tokens(reserved_name_token)
      speakers = Speaker.where(session_token: reserved_name_token).limit(20)
    end

    # if still not found, create more guests first
    unless speakers and speakers.length == 20
      Speaker.create_guests(50)
      n = Speaker.update_reserved_session_tokens(reserved_name_token)
      speakers = Speaker.where(session_token: reserved_name_token).limit(20)
    end

    # we should now have all our reserved names so we can create
    # the name choice issue, but we don't need to save it on the DB
    issue = Issue.new(speaker_id: id, text: "Which Speaker codename do you want?")
    choice_params_arr = speakers.pluck(:codename).map{ |cn| {text: cn}}
    issue.choices.build(choice_params_arr)

    issue
  end

  def to_s
    "#{codename}-#{id}"
  end

end
