class Speaker < ActiveRecord::Base
  belongs_to :verification
  has_many :choices
  has_many :voices
  has_many :issues

  def self.find_guest
  	# this method is not race-condition proof. In future prefer to send
  	# the instruction to the DB to update and save
  	# the first available record of session_token: 'LOGGED_OUT_GUEST'
  	# with session_token: 'RESERVED_GUEST'
  	# and return the id of that record.
  	# The subsequent logic which creates a singular session_token
  	# should then update that returned record.
  	Speaker.find_by session_token: 'LOGGED_OUT_GUEST'
  end

  def to_s
  	codename
  end
end
