module PostsHelper

  # 作業時間の合計を算出する 引数はArray型
  def caluculate_working_times_sum(posts)
    working_times_sum = 0
    posts.each do |post|
      working_times_sum += post.working_total
    end
    working_times_sum
  end
end
