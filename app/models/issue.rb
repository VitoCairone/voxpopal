class Issue < ActiveRecord::Base
  belongs_to :speaker
  has_many :choices
  has_many :voices
  accepts_nested_attributes_for :choices, allow_destroy: true

  def to_s
  	codename
  end
end
