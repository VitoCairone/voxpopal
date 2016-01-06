class Choice < ActiveRecord::Base
  belongs_to :issue
  belongs_to :speaker
end
