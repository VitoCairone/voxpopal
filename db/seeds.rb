# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

team_speaker = Speaker.create(codename: "Voice-America Team", password: SecureRandom.urlsafe_base64(20))
p45 = Issue.create(speaker_id: team_speaker.id, codename: 'P45', text: 'If the election for the next President of the United States were held today, who would you vote for?')

Choice.create([
	{issue_id: p45.id, text: "Jeb Bush"},
	{issue_id: p45.id, text: "Ben Carson"},
	{issue_id: p45.id, text: "Chris Christie"},
	{issue_id: p45.id, text: "Hillary Clinton"},
	{issue_id: p45.id, text: "Ted Cruz"},
	{issue_id: p45.id, text: "Marc Feldmen"},
	{issue_id: p45.id, text: "Carly Fiorina"},
	{issue_id: p45.id, text: "Jim Gilmore"},
	{issue_id: p45.id, text: "Mike Huckabee"},
	{issue_id: p45.id, text: "Gary Johnson"},
	{issue_id: p45.id, text: "John Kasich"},
	{issue_id: p45.id, text: "John McAfee"},
	{issue_id: p45.id, text: "Martin O'Malley"},
	{issue_id: p45.id, text: "Rand Paul"},
	{issue_id: p45.id, text: "Austin Petersen"},
	{issue_id: p45.id, text: "Marco Rubio"},
	{issue_id: p45.id, text: "Bernie Sanders"},
	{issue_id: p45.id, text: "Rick Santorum"},
	{issue_id: p45.id, text: "Jill Stein"},
	{issue_id: p45.id, text: "Donald Trump"},
	{issue_id: p45.id, text: "I would not vote"}
])