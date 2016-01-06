class Speaker < ActiveRecord::Base
  belongs_to :verification
  has_many :choices
  has_many :voices
  has_many :issues

  def to_s
  	codename
  end
end
