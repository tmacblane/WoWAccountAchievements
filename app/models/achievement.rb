require File.dirname(__FILE__) + "/../../config/wow_achievement_connection.rb"

class Achievement < WowAchievementConnection
  def self.searchForAchievement(achievementID)
    @achievement = Achievement.find(:all,
        :conditions => "achievement_id = '#{achievementID}'")

    return @achievement
  end

  def self.searchForAchievementByID(id)
    @achievement = Achievement.find(:all,
        :conditions => "id = '#{id}'")

    return @achievement
  end

  def self.addAchievement(achievementID, category, points, title, description)
    @acheivement = searchForAchievement(achievementID)

    Achievement.create(:achievement_id => "#{achieveID['id']}",
                             :category_id => category,
                             :points => points,
                             :name => title,
                             :description => description,
                             :is_active => 1)
  end

  def self.updateAchievementAttributes(achievementID, category, points, title, description, active)
    @acheivement = searchForAchievement(achievementID)

    Achievement.update(@acheivement[0].id,
                             :category_id => category,
                             :points => points,
                             :name => title,
                             :description => description,
                             :is_active => active)
  end

end
