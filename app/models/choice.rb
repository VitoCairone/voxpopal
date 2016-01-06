class Choice < ActiveRecord::Base
  belongs_to :issue
  belongs_to :speaker
  has_many :voices
end
