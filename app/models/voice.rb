class Voice < ActiveRecord::Base
  belongs_to :speaker
  belongs_to :choice
  belongs_to :issue
end
