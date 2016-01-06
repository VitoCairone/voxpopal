class Issue < ActiveRecord::Base
  belongs_to :speaker
  has_many :choices
end
