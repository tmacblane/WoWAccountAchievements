require File.dirname(__FILE__) + "/../../config/wow_achievement_connection.rb"
require "character.rb"
require "achievement.rb"

class CharacterAchievement < WowAchievementConnection

  def self.find_by_character_id(characterID)
    @characterAchievements = CharacterAchievement.find(:all,
                :conditions => "character_id = '#{characterID}'")

    return @characterAchievements
  end

  def self.create_character_achievement(characterID, achievementID, isComplete)
    CharacterAchievement.create(:character_id => characterID,
              :achievement_id => achievementID,
              :is_complete => isComplete)
  end

  def self.find_by_achievement_id(achievementID)
    @achievementID = CharacterAchievement.find(:all,
            :conditions => "achievement_id = '#{achievementID}'")

    return @achievementID
  end

  def self.find_by_character_and_achievement(characterID, achievementID)
    @achievementID = CharacterAchievement.find(:all,
            :conditions => "achievement_id = '#{achievementID}' AND character_id = '#{characterID}'")
  end

  def self.get_achievement_points_by_character(characterID)
    @characterAchievements = CharacterAchievement.find(:all,
            :conditions => "character_id = '#{characterID}'")

    @total = 0
    @characterAchievements.each do |points|
      #find achievement points by achieveID
      @achievement = Achievement.search_for_achievement_by_id(points.achievement_id)

      @total = @total + @achievement[0].points
    end

    puts @total
  end

  def self.get_unique_achievements(characterIDs)
    @uniqueAchievements = CharacterAchievement.find(:all,
            :select => "DISTINCT(achievement_id)",
            :conditions => "character_id IN (#{characterIDs})")

    @total = 0
    
    @uniqueAchievements.each do |points|
      @achievement = Achievement.search_for_achievement_by_id(points.achievement_id)

      @total = @total + @achievement[0].points.to_i
    end

    puts @total
    return @uniqueAchievements
  end

  #get_unique_achievements("1, 2, 3")
end
