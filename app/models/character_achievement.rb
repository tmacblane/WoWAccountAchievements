require File.dirname(__FILE__) + "/../../config/wow_achievement_connection.rb"
require "character.rb"
require "achievement.rb"

class CharacterAchievement < WowAchievementConnection

  def self.findByCharacterID(characterID)
    @characterAchievements = CharacterAchievement.find(:all,
                :conditions => "character_id = '#{characterID}'")

    return @characterAchievements
  end

  def self.createCharacterAchievement(characterID, achievementID, isComplete)
    CharacterAchievement.create(:character_id => characterID,
              :achievement_id => achievementID,
              :is_complete => isComplete)
  end

  def self.findByAchievementID(achievementID)
    @achievementID = CharacterAchievement.find(:all,
            :conditions => "achievement_id = '#{achievementID}'")

    return @achievementID
  end

  def self.findByCharacterAndAchievement(characterID, achievementID)
    @achievementID = CharacterAchievement.find(:all,
            :conditions => "achievement_id = '#{achievementID}' AND character_id = '#{characterID}'")
  end

  def self.getAchievementPointsByCharacter(characterID)
    @characterAchievements = CharacterAchievement.find(:all,
            :conditions => "character_id = '#{characterID}'")

    @total = 0
    @characterAchievements.each do |points|
      #find achievement points by achieveID
      @achievement = Achievement.searchForAchievementByID(points.achievement_id)

      @total = @total + @achievement[0].points
    end

    puts @total
  end

  def self.getUniqueAchievements
    @uniqueAchievements = CharacterAchievement.find(:all,
            :select => "DISTINCT(achievement_id)",
            :conditions => "character_id IN (6, 7, 8, 9)")

    @total = 0
    
    @uniqueAchievements.each do |points|
      @achievement = Achievement.searchForAchievementByID(points.achievement_id)

      @total = @total + @achievement[0].points
    end

    puts @total
  end

  getUniqueAchievements

end
