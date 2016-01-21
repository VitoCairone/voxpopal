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

  def to_s
    "#{codename}-#{id}"
  end

end
