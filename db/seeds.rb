User.create!(name: "admin",
             email: "admin@gmail.com",
             password: "123456",
             password_confirmation: "123456",
             role: 1)
30.times do |n|
  name = Faker::Name.name
  email = "NguyenVanA-#{n + 1}@gmail.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               role: 0,
               created_at: rand(2.years).seconds.ago)
end

10.times do |n|
  name = "Bai Kiem tra #{n + 2}"
  pass_score = rand(20..30)
  time_limit = rand(10..30)
  image_url = "Screenshot_from_2022-04-16_16-06-26.png"
  u1 = Exam.create!(name: name, pass_score: pass_score, time_limit: time_limit)
  i1 = Image.create!(imageable: u1)
  i1.image_url = Rails.root.join("/home/vuong/Documents/training-exams/app/assets/images/anh3.jpeg").open
  # i1["image_url"] = image_url
  i1.save!
end
