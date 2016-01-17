class Voice < ActiveRecord::Base
  belongs_to :speaker
  belongs_to :choice
  belongs_to :issue

  def self.find_counts_by_choice(issue)
  	# Voice. and self. both work here ?
  	# Lookup canonical way to reduce this run-on
  	choice_counts = Voice.select("choice_id, count(1) as count").where(issue_id: issue.id).group("choice_id")
  	# this is returned as a set of ActiveRecord models but these
  	# are NOT normal ActiveRecord models, so convert to a hash immediately
  	choice_count_hash = {}
  	choice_counts.each { |cc| choice_count_hash[cc.choice_id] = cc.count }
  	# this hash is actually all we need, so just return it
  	choice_count_hash
  end

end
