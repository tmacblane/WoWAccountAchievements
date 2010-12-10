class SetAchievements < ActiveRecord::Migration

  for i in 1..8000
    Achievement.create(:achievement_id => "ach#{i}",
                             :is_active => 0)
  end
end