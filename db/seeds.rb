10.times do |n|
  name = "Bai Kiem tra #{n + 2}"
  pass_score = rand(20..30)
  time_limit = rand(10..30)
  image_url = "Screenshot_from_2022-04-16_16-06-26.png"
  u1 = Exam.create!(name: name, pass_score: pass_score, time_limit: time_limit)
  i1 = Image.create!(imageable: u1)
  i1.image_url = Rails.root.join("/home/nguyenvanson332000/training-exams/app/assets/images/anh3.jpeg").open
  # i1["image_url"] = image_url
  i1.save!
end
