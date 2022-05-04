module AchievementHelper
  def is_passed user_exam
    if user_exam.is_passed == true
      "Passed"
    else
      "Fail"
    end
  end
end
