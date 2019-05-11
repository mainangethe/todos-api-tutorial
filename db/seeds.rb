# create 10 users
user_count = 10
user_count.times do
  random_password = '123456'
  User.create(name: Faker::Name.name_with_middle, email: Faker::Internet.free_email, password: random_password )
end
puts "Created #{ user_count } users"


# seed 5 todo lists with 10 items each per user
users_list = User.all
users_list.each do |user|
  todo_count = rand(30..70)
  todo_count.times do
    todo = Todo.create(title: Faker::Lorem.sentence(5), created_by: user.id)
    item_count = rand(5..15)
    item_count.times do
      todo.items.create(name: Faker::Lorem.sentence(rand(3..7)) , done: Faker::Boolean.boolean )
    end
  end
end
puts "Created #{ Todo.all.count } todo lists and #{ Item.all.count } items"