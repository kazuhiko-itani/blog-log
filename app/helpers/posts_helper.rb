module PostsHelper

  # 作業時間の合計を算出する 引数はArray型
  def caluculate_working_times_sum(posts)
    working_times_sum = 0
    posts.each do |post|
      working_times_sum += post.working_total
    end
    working_times_sum
  end

  # 今日の作業時間の合計を時間単位と分単位に変換する
  def convert_today_working_total_to_hours_and_minutes(today_working_total)
    if today_working_total == 0
      working_today_hour = 0
      working_today_minute = 0
    else
      working_today_hour = today_working_total / 60
      working_today_minute = today_working_total % 60
    end

    return working_today_hour, working_today_minute
  end
end
