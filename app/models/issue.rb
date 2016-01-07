class Issue < ActiveRecord::Base
  belongs_to :speaker
  has_many :choices
  accepts_nested_attributes_for :choices, allow_destroy: true
end
