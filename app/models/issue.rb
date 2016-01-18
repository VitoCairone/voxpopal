class Issue < ActiveRecord::Base
  belongs_to :speaker
  has_many :choices
  has_many :voices
  accepts_nested_attributes_for :choices, allow_destroy: true

  def self.unseen_by_speaker(speaker, limit=3)
    # Target SQL -----
    # SELECT issue.* FROM issues i
    # LEFT JOIN voices v ON v.issue_id = i.id
    # AND v.speaker_id = {current_speaker.id}
    # WHERE v.id IS NULL

    # FORCE CHECK that speaker.id exists and is integer
    Issue.joins("LEFT OUTER JOIN voices ON voices.issue_id = issues.id AND voices.speaker_id = #{speaker.id}").where("voices.id IS NULL").limit(limit)
  end

  def to_s
    codename
  end

  def top(n, offset)
    # query the DB here
    #
    # note: MAKE SURE the database keeps an index of Issue by Boost.
    # That way, this query performs O(log m) where m is the db size.
    # Without an index it is O(m log m) or potentially worse.
    self.order_by(:boost).limit(n, offset)
  end
end
