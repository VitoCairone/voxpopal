class Speaker < ActiveRecord::Base
  belongs_to :verification
  has_many :choices
  has_many :voices
  has_many :issues

  def self.find_guest
  	# this method is not race-condition proof. In future prefer to send
  	# the instruction to the DB to update and save
  	# the first available record of session_token: 'LOGGED_OUT_GUEST'
  	# with session_token: 'RESERVED_GUEST'
  	# and return the id of that record.
  	# The subsequent logic which creates a singular session_token
  	# should then update that returned record.
  	speaker = Speaker.find_or_create_by(session_token: 'LOGGED_OUT_GUEST')
      
  end

  def get_available_codename
    # this current implementation isn't tightly time-constrained or collision-proof
    # prerer in the future pulling and reserving from a pre-created list
    list_1 = [
      'Noble ',
      'Valiant ',
      'Kind ',
      'Swift ',
      'Strong ',
      'Clever ',
      'Shining ',
      'Righteous ',
      'Wise ',
      'Proud ',
      'Brave ',
      'Honest ',
      'Awesome ',
      'Triumphant ',
      'Furious ',
      'Leaping ',
      'Fighting ',
      'Champion ',
      'Smiling ',
      'Rising ',
      'Flying ',
      'Grinning '
    ]

    list_2 = [
      'Red ',
      'Orange ',
      'Yellow ',
      'Green ',
      'Blue ',
      'Violet ',
      'White ',
      'Black ',
      'Brown ',
      'Pink ',
      'Snow ',
      'Fire ',
      'Earth ',
      'Wind ',
      'Water ',
      'Electric ',
      'Space ',
      'Thunder ',
      'Sonic ',
      'Little ',
      'Big '
    ]

    list_3 = [
      'Eagle',
      'Lion',
      'Wolf',
      'Fox',
      'Wildcat',
      'Horse',
      'Rabbit',
      'Seal',
      'Tiger',
      'Owl',
      'Dove',
      'Songbird',
      'Swan',
      'Gator',
      'Dolphin',
      'Bumblebee',
      'Grasshopper',
      'Deer',
      'Turtle'
    ]

    not_original = true
    while not_original do
      codename = list_1.sample + list_2.sample + list_3.sample
      not_original = !!(Speaker.find_by_codename(codename))
    end
    codename
  end

  def to_s
  	codename
  end
end
