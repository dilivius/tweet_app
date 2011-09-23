require 'faker'
namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
  	Rake::Task['db:reset'].invoke
  	admin = User.create!(:name => "Di Livius",
  				 :email => "di_livius@yahoo.com",
  				 :password => "barfoo",
  				 :password_confirmation => "barfoo")
  	admin.toggle!(:admin)
  	99.times do |n|
  		name = Faker::Name.name
  		email = "john-#{n+1}@yahoo.com"
  		password = "barfoo"
  		User.create!(:name => name,
  					 :email => email,
  					 :password => password,
  					 :password_confirmation => password)
  	end
  end
end