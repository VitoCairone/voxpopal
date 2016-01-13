class Choice < ActiveRecord::Base
  belongs_to :issue
  belongs_to :speaker
  has_many :voices

	def to_s
  	"... " + text[10..-1]
  end
end
