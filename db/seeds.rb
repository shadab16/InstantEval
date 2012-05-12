# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

StatusCode.create(name: "MEM", description: "Memory Limit Exhausted")
StatusCode.create(name: "CPU", description: "Time Limit Exhausted")
StatusCode.create(name: "HANG", description: "Program Hangup Detected")
StatusCode.create(name: "SIG", description: "Process Killed by Signal")
StatusCode.create(name: "OK", description: "Successful Submission")
StatusCode.create(name: "EXIT", description: "Non-Zero Exit Code")
StatusCode.create(name: "COMPILE", description: "Compilation Error")
StatusCode.create(name: "FAIL", description: "Wrong Answer")

ProgrammingLanguage.create(name: "C", available: true)
ProgrammingLanguage.create(name: "C++", available: true)

user = User.new(email: "test@example.com", password: "qwerty")
user.roles = ["admin"]
user.save

