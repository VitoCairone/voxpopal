class Issue < ActiveRecord::Base
  belongs_to :speaker
  has_many :choices
  has_many :voices
  accepts_nested_attributes_for :choices, allow_destroy: true

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
