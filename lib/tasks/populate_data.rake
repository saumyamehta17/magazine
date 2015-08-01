namespace :db do
  desc "Erase and fill the database"
  task populate: :environment do
    Faker::Config.locale = :en
    require 'faker'
    Article.delete_all
    Article.populate 10 do |art|
      art.user_id = User.first.id
      art.title = Faker::Name.title
      art.body = Faker::Lorem.sentence
      art.author = Faker::Name.name
    end
  end
end