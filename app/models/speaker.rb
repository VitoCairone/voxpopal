class Speaker < ActiveRecord::Base
  belongs_to :verification

  def to_s
  	codename
  end
end
