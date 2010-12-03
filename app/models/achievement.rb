require File.dirname(__FILE__) + "/../../config/wow_achievement_connection.rb"

class Achievement < WowAchievementConnection
  def self.search_for_achievement(achievementID)
    @achievement = Achievement.find(:all,
        :conditions => "achievement_id = '#{achievementID}'")

    return @achievement
  end

  def self.search_for_achievement_by_id(id)
    @achievement = Achievement.find(:all,
        :conditions => "id = '#{id}'")

    return @achievement
  end

  def self.add_achievement(achievementID, category, points, title, description)
    @acheivement = search_for_achievement(achievementID)

    Achievement.create(:achievement_id => "#{achieveID['id']}",
                             :category_id => category,
                             :points => points,
                             :name => title,
                             :description => description,
                             :is_active => 1)
  end

  def self.update_achievement_attributes(achievementID, category, points, title, description, active)
    @acheivement = search_for_achievement(achievementID)

    Achievement.update(@acheivement[0].id,
                             :category_id => category,
                             :points => points,
                             :name => title,
                             :description => description,
                             :is_active => active)
  end

  def self.update_criteria_achievement_attributes(achievementID, category, points, title, active)
    @acheivement = search_for_achievement(achievementID)

    Achievement.update(@acheivement[0].id,
                             :category_id => category,
                             :points => points,
                             :name => title,
                             :is_active => active)
  end

end
