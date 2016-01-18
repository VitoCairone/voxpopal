class SpeakerHistory < ActiveRecord::Base
  belongs_to :speaker
  belongs_to :issue_spare_1
  belongs_to :issue_spare_2
  belongs_to :issue_spare_3
  belongs_to :issue_next
  belongs_to :issue_prev
end
