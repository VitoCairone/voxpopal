class Comment < ActiveRecord::Base
  belongs_to :speaker
  belongs_to :parent, polymorphic: true
end
